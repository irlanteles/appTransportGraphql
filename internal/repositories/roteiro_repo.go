package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"strings"

	"github.com/irlanteles/api-graphql/graph/model"
)

type RoteiroRepository struct {
	db *sql.DB
}

func NewRoteiroRepository(db *sql.DB) *RoteiroRepository {
	return &RoteiroRepository{db: db}
}

func (r *RoteiroRepository) UpdateRoteiro(ctx context.Context, input model.UpdateRoteiroInput) (*model.UpdateRoteiroPayload, error) {
	if input.RoteiroSt == nil && input.DataHoraInicio == nil && input.DataHoraFim == nil {
		return &model.UpdateRoteiroPayload{
			Mensagem: "Nenhum campo informado para atualização.",
			Status:   false,
		}, nil
	}

	var setParts []string
	var args []interface{}
	argID := 1

	if input.RoteiroSt != nil {
		setParts = append(setParts, fmt.Sprintf("roteiro_st = $%d", argID))
		args = append(args, *input.RoteiroSt)
		argID++
	}

	if input.DataHoraInicio != nil {
		setParts = append(setParts, fmt.Sprintf("data_hora_inicio = $%d", argID))
		args = append(args, *input.DataHoraInicio)
		argID++
	}

	if input.DataHoraFim != nil {
		setParts = append(setParts, fmt.Sprintf("data_hora_fim = $%d", argID))
		args = append(args, *input.DataHoraFim)
		argID++
	}

	query := "UPDATE transporte.roteiro SET " + strings.Join(setParts, ", ")
	query += fmt.Sprintf(" WHERE roteiro_id = $%d", argID)
	args = append(args, input.RoteiroID)

	res, err := r.db.ExecContext(ctx, query, args...)
	if err != nil {
		return nil, fmt.Errorf("erro ao atualizar roteiro: %v", err)
	}

	rowsAffected, err := res.RowsAffected()
	if err != nil {
		return nil, fmt.Errorf("erro ao verificar linhas afetadas: %v", err)
	}

	if rowsAffected == 0 {
		return &model.UpdateRoteiroPayload{
			Mensagem: "Nenhum roteiro encontrado com esse ID.",
			Status:   false,
		}, nil
	}

	return &model.UpdateRoteiroPayload{
		Mensagem: "Roteiro atualizado com sucesso.",
		Status:   true,
	}, nil
}
