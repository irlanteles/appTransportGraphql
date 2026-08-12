package services

import (
	"context"

	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type RoteiroService struct {
	Repo *repositories.RoteiroRepository
}

func NewRoteiroService(repo *repositories.RoteiroRepository) *RoteiroService {
	return &RoteiroService{Repo: repo}
}

func (s *RoteiroService) UpdateRoteiro(ctx context.Context, input model.UpdateRoteiroInput) (*model.UpdateRoteiroPayload, error) {
	return s.Repo.UpdateRoteiro(ctx, input)
}
