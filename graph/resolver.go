package graph

import (
	"github.com/irlanteles/api-graphql/internal/services"
)

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require
// here.

type Resolver struct {
	ChecklistService *services.ChecklistService
	CheckoutService  *services.CheckoutService
	ViagemService    *services.ViagemService
	DashboardService  *services.DashboardService
	VeiculoService    *services.VeiculoService
	PassageiroService *services.PassageiroService
	RoteiroService    *services.RoteiroService
	SolicitacaoService *services.SolicitacaoService
}
