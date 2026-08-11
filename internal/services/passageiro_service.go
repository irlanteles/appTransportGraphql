package services

import (
	"context"

	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type PassageiroService struct {
	repo *repositories.PassageiroRepository
}

func NewPassageiroService(repo *repositories.PassageiroRepository) *PassageiroService {
	return &PassageiroService{repo: repo}
}

func (s *PassageiroService) ListarPassageiros(ctx context.Context, numeroSolicitacao string) ([]*model.Passageiro, error) {
	return s.repo.ListarPassageiros(ctx, numeroSolicitacao)
}
