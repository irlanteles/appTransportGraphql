package services

import (
	"context"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type CheckoutService struct {
	repo *repositories.CheckoutRepository
}

func NewCheckoutService(repo *repositories.CheckoutRepository) *CheckoutService {
	return &CheckoutService{repo: repo}
}

func (s *CheckoutService) Criar(ctx context.Context, c *model.CheckoutInput) (int, error) {
	return s.repo.Inserir(c)
}
