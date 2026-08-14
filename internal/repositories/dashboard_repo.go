package repositories

import (
	"database/sql"
	"fmt"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/utils"
)

type DashboardRepository struct {
	db *sql.DB
}

func NewDashboardRepository(db *sql.DB) *DashboardRepository {
	return &DashboardRepository{db: db}
}

// GetDashboardData busca os dados consolidados a partir da vw_viagens
func (r *DashboardRepository) GetDashboardData(idMotorista string) (*model.Dashboard, error) {
	// A query abaixo assume que podemos filtrar pelo motorista (id ou nome dependendo do que idMotorista significa).
	// O init.md diz "dashboard(idMotorista: ID!)" e a vw_viagens tem motorista (pessoa_nm).
	// A VIEW vw_viagens não exporta o pessoa_id do motorista! Mas tem "solicitante", "motorista", etc.
	// Vamos precisar fazer um JOIN direto com a view ou assumir que a view será consultada.
	// O mais prudente é usar as tabelas subjacentes se o ID for numérico.
	
	// Vamos construir a query utilizando SQL ANSI, juntando vw_viagens e pegando o id do motorista 
	// da tabela solicitacao/pessoa, ou consultando a vw_viagens filtrando pelo ID caso haja um join que o suporte.
	
	query := `
		SELECT 
			s.solicitacao_id,
			s.solicitacao_motorista AS motorista_id,
			s.solicitacao_situacao, 
			p.pessoa_nm AS motorista_nome,
			s.solicitacao_numero,
			r.roteiro_id  as viagem_id,
			COALESCE(m.municipio_ds, '') AS origem,
			COALESCE(r.roteiro_local, '') AS destino,
			TO_CHAR(s.solicitacao_saida_dt_prevista, 'YYYY-MM-DD') AS dataInicio,
			TO_CHAR(s.solicitacao_saida_dt_prevista, 'HH24:MI') AS horarioInicio,
			TO_CHAR(s.solicitacao_retorno_dt_prevista , 'YYYY-MM-DD') AS dataFinal,
			TO_CHAR(s.solicitacao_retorno_dt_prevista, 'HH24:MI') AS horarioFinal,
			COALESCE(p2.pessoa_nm, '') AS solicitante,
			COALESCE(p3.pessoa_nm, '') AS autorizado,
			COALESCE(s.solicitacao_roteiro_ds, '') AS roteiroDs
		FROM transporte.solicitacao s
		JOIN dados_unico.pessoa p ON p.pessoa_id = s.solicitacao_motorista
		LEFT JOIN transporte.solicitacao_autorizacao sa ON sa.solicitacao_id = s.solicitacao_id
		LEFT JOIN dados_unico.pessoa p3 ON p3.pessoa_id = sa.solicitacao_autorizacao_func
		LEFT JOIN dados_unico.pessoa p2 ON s.solicitacao_solicitante = p2.pessoa_id
		left join transporte.veiculo v on s.veiculo_id = v.veiculo_id
		JOIN transporte.roteiro r  ON r.solicitacao_id = s.solicitacao_id
		left join dados_unico.municipio m on m.municipio_cd = r.roteiro_origem
		left join dados_unico.municipio m2 on m2.municipio_cd  = r.roteiro_destino 
		WHERE s.solicitacao_motorista = $1
		and s.solicitacao_st = 0
		and s.solicitacao_situacao = 2
	`
	
	rows, err := r.db.Query(query, idMotorista)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	dashboard := &model.Dashboard{}
	viagensMap := make(map[string]*model.ViagemDashboard)
	motoristaPreenchido := false

	for rows.Next() {
		var solicitacaoID int
		var motoristaID int
		var situacao sql.NullInt32
		var motoristaNome string
		var numSolicitacao string
		var roteiroId int
		var origem sql.NullString
		var destino string
		var dataInicio sql.NullString
		var horarioInicio sql.NullString
		var dataFinal sql.NullString
		var horarioFinal sql.NullString
		var solicitante string
		var autorizado string
		var roteiroDs sql.NullString

		err := rows.Scan(
			&solicitacaoID, &motoristaID, &situacao, &motoristaNome, &numSolicitacao, &roteiroId,
			&origem, &destino, &dataInicio, &horarioInicio, &dataFinal, &horarioFinal,
			&solicitante, &autorizado, &roteiroDs,
		)
		if err != nil {
			return nil, err
		}

		id := int32(motoristaID)

		if !motoristaPreenchido {
			dashboard.Motorista = &model.Motorista{
				ID:   &id,
				Nome: utils.ToUTF8(motoristaNome),
			}
			motoristaPreenchido = true
		}

		viagem, exists := viagensMap[numSolicitacao]
		if !exists {
			rotDsStr := ""
			if roteiroDs.Valid { rotDsStr = utils.ToUTF8(roteiroDs.String) }
			var rotDsPtr *string
			if rotDsStr != "" { rotDsPtr = &rotDsStr }

			viagem = &model.ViagemDashboard{
				SolicitacaoID:     int32(solicitacaoID),
				NumeroSolicitacao: numSolicitacao,
				RoteiroDs:         rotDsPtr,
				Paradas:           []*model.Parada{},
			}
			viagensMap[numSolicitacao] = viagem
		}

		dtInicio := ""
		hrInicio := ""
		dtFinal := ""
		hrFinal := ""
		if dataInicio.Valid { dtInicio = dataInicio.String }
		if horarioInicio.Valid { hrInicio = horarioInicio.String }
		if dataFinal.Valid { dtFinal = dataFinal.String }
		if horarioFinal.Valid { hrFinal = horarioFinal.String }

		origemStr := ""
		if origem.Valid { origemStr = origem.String }

		viagem.Paradas = append(viagem.Paradas, &model.Parada{
			RoteiroID:     int32(roteiroId),
			DataInicio:    dtInicio,
			HorarioInicio: hrInicio,
			DataFinal:     dtFinal,
			HorarioFinal:  hrFinal,
			Ordem:         0,
			Solicitante:   utils.ToUTF8(solicitante),
			Autorizado:    utils.ToUTF8(autorizado),
			Origem:        utils.ToUTF8(origemStr),
			Destino:       utils.ToUTF8(destino),
		})
	}

	for _, v := range viagensMap {
		dashboard.Viagens = append(dashboard.Viagens, v)
	}
	if !motoristaPreenchido {
		return nil, fmt.Errorf("nenhum dado encontrado para o motorista %s", idMotorista)
	}

	return dashboard, nil
}
