package services

import (
	"context"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

type ViagemService struct {
	repo *repositories.ViagemRepository
}

func NewViagemService(repo *repositories.ViagemRepository) *ViagemService {
	return &ViagemService{repo: repo}
}

func (s *ViagemService) CriarViagem(
	ctx context.Context,
	solicitante int,
	qtdpessoa string,
	tipoVeiculo int,
	enderecos []string,
	roteiroDs string,
	obs string,
	dt string,
	hr string,
	saidaDtPrevista string,
	retornoDtPrevista string,
	unidadeCusto int,
	situacao int,
	st int,
	dtCriacao string,
	solicitanteEst int,
	projetoCd int,
	acaoCd int,
	territorioCd int,
	fonteCd int,
	numero string,
	qtdPessoa int,
	passageiroIds []int,
	ordem int,
) error {
	// Validação de negócio (Ex: verificar se endereços estão preenchidos)
	if len(enderecos) == 0 {
		return context.Canceled // Usando context error symbolicamente para validação
	}

	return s.repo.InserirViagem(
		solicitante, qtdpessoa, tipoVeiculo, enderecos, roteiroDs,
		obs, dt, hr, saidaDtPrevista, retornoDtPrevista,
		unidadeCusto, situacao, st, dtCriacao, solicitanteEst,
		projetoCd, acaoCd, territorioCd, fonteCd, numero,
		qtdPessoa, passageiroIds, ordem,
	)
}
