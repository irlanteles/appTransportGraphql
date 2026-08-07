package services

import (
	"context"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type ChecklistService struct {
	repo *repositories.ChecklistRepository
}

func NewChecklistService(repo *repositories.ChecklistRepository) *ChecklistService {
	return &ChecklistService{repo: repo}
}

func (s *ChecklistService) Criar(ctx context.Context, c *model.ChecklistInput) (int, error) {
	// Regras de negócio, validações, etc poderiam ir aqui
	return s.repo.Inserir(c)
}
