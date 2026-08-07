package services

import (
	"context"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type VeiculoService struct {
	repo *repositories.VeiculoRepository
}

func NewVeiculoService(repo *repositories.VeiculoRepository) *VeiculoService {
	return &VeiculoService{repo: repo}
}

func (s *VeiculoService) ListarVeiculos(ctx context.Context) ([]*model.Veiculo, error) {
	return s.repo.BuscarVeiculosDisponiveis(ctx)
}
