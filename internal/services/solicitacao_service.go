package services

import (
	"context"

	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type SolicitacaoService struct {
	Repo *repositories.SolicitacaoRepository
}
func NewSolicitacaoService(repo *repositories.SolicitacaoRepository) *SolicitacaoService {
	return &SolicitacaoService{Repo: repo}
}

func (s *SolicitacaoService) UpdateSolicitacao(ctx context.Context, input model.UpdateSolicitacaoInput) (*model.UpdateSolicitacaoPayload, error) {
	return s.Repo.UpdateSolicitacao(ctx, input)
}
