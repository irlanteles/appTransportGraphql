package repositories

import (
	"context"
	"database/sql"

	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/utils"
)

type PassageiroRepository struct {
	db *sql.DB
}

func NewPassageiroRepository(db *sql.DB) *PassageiroRepository {
	return &PassageiroRepository{db: db}
}

func (r *PassageiroRepository) ListarPassageiros(ctx context.Context, numeroSolicitacao string) ([]*model.Passageiro, error) {
	query := `
		select p2.pessoa_id ,p2.pessoa_nm ,p.solicitacao_id ,p.passageiro_st, s.solicitacao_numero  
		from transporte.passageiro p
		left join dados_unico.pessoa p2 on p.pessoa_id = p2.pessoa_id
		left join transporte.solicitacao s  on s.solicitacao_id = p.solicitacao_id 
		where s.solicitacao_numero = $1
	`
	rows, err := r.db.QueryContext(ctx, query, numeroSolicitacao)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var passageiros []*model.Passageiro
	for rows.Next() {
		var p model.Passageiro
		var pessoaID sql.NullInt32
		var pessoaNm sql.NullString
		var solicitacaoID sql.NullInt32
		var passageiroSt sql.NullInt32
		var solicitacaoNumero sql.NullString

		err := rows.Scan(
			&pessoaID,
			&pessoaNm,
			&solicitacaoID,
			&passageiroSt,
			&solicitacaoNumero,
		)
		if err != nil {
			return nil, err
		}

		if pessoaID.Valid {
			p.PessoaID = pessoaID.Int32
		}
		if pessoaNm.Valid {
			p.PessoaNm = utils.ToUTF8(pessoaNm.String)
		}
		if solicitacaoID.Valid {
			p.SolicitacaoID = solicitacaoID.Int32
		}
		if passageiroSt.Valid {
			p.PassageiroSt = passageiroSt.Int32
		}
		if solicitacaoNumero.Valid {
			p.SolicitacaoNumero = solicitacaoNumero.String
		}

		passageiros = append(passageiros, &p)
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	return passageiros, nil
}
