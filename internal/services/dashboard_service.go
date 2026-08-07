package services

import (
	"context"
	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type DashboardService struct {
	repo *repositories.DashboardRepository
}

func NewDashboardService(repo *repositories.DashboardRepository) *DashboardService {
	return &DashboardService{repo: repo}
}

func (s *DashboardService) ObterDashboard(ctx context.Context, idMotorista string) (*model.Dashboard, error) {
	return s.repo.GetDashboardData(idMotorista)
}
