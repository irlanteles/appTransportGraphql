package repositories

import (
 	"context"
 	"database/sql"
	"fmt"
	"strings"
	"github.com/irlanteles/api-graphql/graph/model"
)
type SolicitacaoRepository struct {
	db *sql.DB
}
func NewSolicitacaoRepository(db *sql.DB) *SolicitacaoRepository {
	return &SolicitacaoRepository{db: db}
}
func (r *SolicitacaoRepository) UpdateSolicitacao(ctx context.Context, input model.UpdateSolicitacaoInput) (*model.UpdateSolicitacaoPayload, error) {
	if input.SolicitacaoSituacao == nil &&
		input.SolicitacaoSaidaDt == nil &&
	 input.SolicitacaoRetornoDt == nil &&
	 input.SolicitacaoSt == nil &&
		input.SolicitacaoKminicial == nil &&
		input.SolicitacaoKmfinal == nil {
		return &model.UpdateSolicitacaoPayload{
			Mensagem: "Nenhum campo informado para atualização.",
			Status:   false,
		}, nil
	}

var setParts []string
var args []interface{}
argID := 1

if input.SolicitacaoSituacao != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_situacao = $%d", argID))
	args = append(args, *input.SolicitacaoSituacao)
	argID++
}

if input.SolicitacaoSaidaDt != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_saida_dt = $%d::timestamp", argID))
	args = append(args, *input.SolicitacaoSaidaDt)
	argID++
}

if input.SolicitacaoRetornoDt != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_retorno_dt = $%d::timestamp", argID))
	args = append(args, *input.SolicitacaoRetornoDt)
	argID++
}

if input.SolicitacaoSt != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_st = $%d", argID))
	args = append(args, *input.SolicitacaoSt)
	argID++
}

if input.SolicitacaoKminicial != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_kminicial = $%d", argID))
	args = append(args, *input.SolicitacaoKminicial)
	argID++
}

if input.SolicitacaoKmfinal != nil {
	setParts = append(setParts, fmt.Sprintf("solicitacao_kmfinal = $%d", argID))
	args = append(args, *input.SolicitacaoKmfinal)
	argID++
}

setParts = append(setParts, "solicitacao_dt_alteracao = CURRENT_DATE")

query := "UPDATE transporte.solicitacao SET " + strings.Join(setParts, ", ")
query += fmt.Sprintf(" WHERE solicitacao_id = $%d", argID)
args = append(args, input.SolicitacaoID)

res, err := r.db.ExecContext(ctx, query, args...)
if err != nil {
	return &model.UpdateSolicitacaoPayload{
		Mensagem: fmt.Sprintf("Erro ao atualizar solicitacao: %v", err),
		Status:   false,
	}, nil
}

rowsAffected, err := res.RowsAffected()
if err != nil {
	return &model.UpdateSolicitacaoPayload{
		Mensagem: "Erro ao verificar status da atualização.",
		Status:   false,
	}, nil
}

if rowsAffected == 0 {
	return &model.UpdateSolicitacaoPayload{
		Mensagem: "Nenhuma solicitacão encontrada com esse ID.",
		Status:   false,
	}, nil
}

solicitacao, err := r.ObterSolicitacaoPorID(ctx, input.SolicitacaoID)
if err != nil {
	return &model.UpdateSolicitacaoPayload{
		Mensagem: "Solicitação atualizada, mas erro ao buscar dados atualizados.",
		Status:   true,
	}, nil
}

return &model.UpdateSolicitacaoPayload{
	Mensagem:    "Solicitação atualizada com sucesso.",
	Status:      true,
	Solicitacao: solicitacao,
}, nil
}
func (r *SolicitacaoRepository) ObterSolicitacaoPorID(ctx context.Context, id int32) (*model.Solicitacao, error) {
	query := `
		SELECT 
			solicitacao_id,
		solicitacao_situacao,
		solicitacao_saida_dt,
		solicitacao_retorno_dt,
			solicitacao_st,
		solicitacao_kminicial,
			solicitacao_kmfinal,
			solicitacao_dt_alteracao
	 FROM transporte.solicitacao
	WHERE solicitacao_id = $1
	`

	row := r.db.QueryRowContext(ctx, query, id)

	var solID int32
	var situacao, st sql.NullInt32
	var kmInicial, kmFinal sql.NullString
	var saidaDt,
retornDt, dtAlteracao sql.NullTime

	err := row.Scan(&solID, &situacao, &saidaDt, &retornDt, &st, &kmInicial, &kmFinal, &dtAlteracao)
	if err != nil {
		return nil, err
	}

	sol := &model.Solicitacao{
		SolicitacaoID: solID,
	}

	if situacao.Valid {
		sol.SolicitacaoSituacao = &situacao.Int32
	}
	if st.Valid {
		sol.SolicitacaoSt = &st.Int32
	}
	if kmInicial.Valid {
		sol.SolicitacaoKminicial = &kmInicial.String
	}
	if kmFinal.Valid {
		sol.SolicitacaoKmfinal = &kmFinal.String
	}
	if saidaDt.Valid {
		formatted := saidaDt.Time.Format("2006-01-02 15:04:05")
		sol.SolicitacaoSaidaDt = &formatted
	}
	if retornDt.Valid {
		formatted := retornDt.Time.Format("2006-01-02 15:04:05")
		sol.SolicitacaoRetornoDt = &formatted
	}
	if dtAlteracao.Valid {
		formatted := dtAlteracao.Time.Format("2006-01-02")
		sol.SolicitacaoDtAlteracao = &formatted
	}

	return sol, nil
}