package repositories

import (
	"database/sql"
	"fmt"
	"github.com/irlanteles/api-graphql/graph/model"
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
			s.solicitacao_motorista AS motorista_id,
			p.pessoa_nm AS motorista_nome,
			s.solicitacao_numero,
			vi.id as viagem_id,
			COALESCE(vi.endereco, '') AS destino,
			TO_CHAR(vi.data_hora_inicio, 'YYYY-MM-DD') AS dataInicio,
			TO_CHAR(vi.data_hora_inicio, 'HH24:MI') AS horarioInicio,
			TO_CHAR(vi.data_hora_final, 'YYYY-MM-DD') AS dataFinal,
			TO_CHAR(vi.data_hora_final, 'HH24:MI') AS horarioFinal,
			vi.ordem ,
			COALESCE(p2.pessoa_nm, '') AS solicitante,
			COALESCE(p3.pessoa_nm, '') AS autorizado,
			vi2.endereco   AS origem -- A origem no banco para parada normalmente depende da sequencia, usamos valor default ou o endereço da solicitação anterior.
		FROM transporte.solicitacao s
		JOIN dados_unico.pessoa p ON p.pessoa_id = s.solicitacao_motorista
		LEFT JOIN transporte.solicitacao_autorizacao sa ON sa.solicitacao_id = s.solicitacao_id
		LEFT JOIN dados_unico.pessoa p3 ON p3.pessoa_id = sa.solicitacao_autorizacao_func
		LEFT JOIN dados_unico.pessoa p2 ON s.solicitacao_solicitante = p2.pessoa_id
		left join transporte.veiculo v on s.veiculo_id = v.veiculo_id
		JOIN transporte.viagem vi ON vi.solicitacao_id = s.solicitacao_id
		left join transporte.viagem vi2 on s.endereco_origem_id = vi2.id 
		WHERE s.solicitacao_motorista = $1
		ORDER BY s.solicitacao_numero, vi.ordem asc
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
		var motoristaID int
		var motoristaNome string
		var numSolicitacao string
		var destino string
		var dataInicio sql.NullString
		var horarioInicio sql.NullString
		var dataFinal sql.NullString
		var horarioFinal sql.NullString
		var solicitante string
		var autorizado string
		var origem string
		var viagemID int
		var ordem int

		err := rows.Scan(
			&motoristaID, &motoristaNome, &numSolicitacao, &viagemID, &destino, 
			&dataInicio, &horarioInicio, &dataFinal, &horarioFinal, &ordem, &solicitante, &autorizado, &origem,
		)
		if err != nil {
			return nil, err
		}


		id:= int32(motoristaID)

		if !motoristaPreenchido {
			dashboard.Motorista = &model.Motorista{
				ID:   &id,
				Nome: motoristaNome,
			}
			motoristaPreenchido = true
		}

		viagem, exists := viagensMap[numSolicitacao]
		if !exists {
			viagem = &model.ViagemDashboard{
				NumeroSolicitacao: numSolicitacao,
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

		viagem.Paradas = append(viagem.Paradas, &model.Parada{
			ViagemID:      int32(viagemID),
			DataInicio:    dtInicio,
			HorarioInicio: hrInicio,
			DataFinal:     dtFinal,
			HorarioFinal:  hrFinal,
			Ordem:         int32(ordem),
			Solicitante:   solicitante,
			Autorizado:    autorizado,
			Origem:        origem,
			Destino:       destino,
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


