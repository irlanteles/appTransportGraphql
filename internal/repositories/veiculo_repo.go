package repositories

import (
	"context"
	"database/sql"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/utils"
)

type VeiculoRepository struct {
	db *sql.DB
}

func NewVeiculoRepository(db *sql.DB) *VeiculoRepository {
	return &VeiculoRepository{db: db}
}

func (r *VeiculoRepository) BuscarVeiculosDisponiveis(ctx context.Context) ([]*model.Veiculo, error) {
	query := `
		SELECT 
			v.veiculo_id, 
			v.veiculo_placa, 
			v.tipo_veiculo_id,
			v.veiculo_st,
			v.veiculo_dt_criacao,
			v.veiculo_tag,
			v.pessoa_id,
			v.hodometro_inicial,
			v.hodometro_final,
			tv.tipo_veiculo_ds,
			tv.tipo_veiculo_qtd_passageiro 
		FROM transporte.veiculo v 
		LEFT JOIN transporte.tipo_veiculo tv ON v.tipo_veiculo_id = tv.tipo_veiculo_id 
		WHERE v.veiculo_st = 0
	`

	rows, err := r.db.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var veiculos []*model.Veiculo
	for rows.Next() {
		var v model.Veiculo
		
		// Lidar com possíveis nulos (sql.NullString, sql.NullInt32)
		var dtCriacao sql.NullString
		var tag sql.NullString
		var pessoaID sql.NullInt32
		var hInicial sql.NullInt32
		var hFinal sql.NullInt32
		var tpVeiculoDs sql.NullString

		err := rows.Scan(
			&v.VeiculoID,
			&v.VeiculoPlaca,
			&v.TipoVeiculoID,
			&v.VeiculoSt,
			&dtCriacao,
			&tag,
			&pessoaID,
			&hInicial,
			&hFinal,
			&tpVeiculoDs,
			&v.TipoVeiculoQtdPassageiro,
		)
		if err != nil {
			return nil, err
		}

		if tpVeiculoDs.Valid {
			utf8Str := utils.ToUTF8(tpVeiculoDs.String)
			v.TipoVeiculoDs = &utf8Str
		}

		if dtCriacao.Valid {
			v.VeiculoDtCriacao = &dtCriacao.String
		}
		if tag.Valid {
			v.VeiculoTag = &tag.String
		}
		if pessoaID.Valid {
			pid := int32(pessoaID.Int32)
			v.PessoaID = &pid
		}
		if hInicial.Valid {
			hin := int32(hInicial.Int32)
			v.HodometroInicial = &hin
		}
		if hFinal.Valid {
			hf := int32(hFinal.Int32)
			v.HodometroFinal = &hf
		}

		veiculos = append(veiculos, &v)
	}

	return veiculos, nil
}
