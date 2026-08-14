package repositories_test

import (
	"context"
	"os"
	"testing"

	"github.com/irlanteles/api-graphql/graph/model"
	"github.com/irlanteles/api-graphql/internal/database"
	"github.com/irlanteles/api-graphql/internal/repositories"
)

func TestUpdateSolicitacao_NoFields(t *testing.T) {
	repo := repositories.NewSolicitacaoRepository(nil)
	ctx := context.Background()

	input := model.UpdateSolicitacaoInput{
	SolicitacaoID: 59111,
	}

	payload, err := repo.UpdateSolicitacao(ctx, input)
	if err != nil {
		t.Fatalf("Erro inesperado: %v", err)
	}

	if payload.Status {
		t.Errorf("Esperado status=false para atualização sem campos, obteve status=true")
	}

	if payload.Mensagem != "Nenhum campo informado para atualização." {
		t.Errorf("Mensagem inesperada: %s", payload.Mensagem)
	}
}

func TestUpdateSolicitacao_Integration(t *testing.T) {
	if os.Getenv("DB_HOST") == "" {
		t.Skip("Pulando teste de integração: DB_HOST não configurado")
	}

	db, err := database.Connect()
	if err != nil {
		t.Fatalf("Erro ao conectar no banco para teste: %v", err)
	}
	defer db.Close()

	repo := repositories.NewSolicitacaoRepository(db)
	ctx := context.Background()

	situacao := int32(1)
	st := int32(1)
	kmInicial := "1000"
	kmFinal := "1050"

	inputPartial := model.UpdateSolicitacaoInput{
	SolicitacaoID:        59111,
	SolicitacaoSituacao:  &situacao,
	SolicitacaoSt:        &st,
	SolicitacaoKminicial: &kmInicial,
	SolicitacaoKmfinal:   &kmFinal,
	}

	payloadPartial, err := repo.UpdateSolicitacao(ctx, inputPartial)
	if err != nil {
		t.Fatalf("Erro na atualização parcial: %va", err)
	}

	if !payloadPartial.Status {
		t.Errorf("Esperado status=true na atualização parcial, obteve %v com mensagem: %s", payloadPartial.Status, payloadPartial.Mensagem)
	}

	if payloadPartial.Solicitacao == nil {
		t.Fatalf("Objeto Solicitacao não retornado no payload")
	}

	if payloadPartial.Solicitacao.SolicitacaoID != 59111 {
		t.Errorf("Esperado solicitacao_id 59111, obteve %d", payloadPartial.Solicitacao.SolicitacaoID)
	}

	inputInexistente := model.UpdateSolicitacaoInput{
	SolicitacaoID:       99999999,
	SolicitacaoSituacao: &situacao,
	}

	payloadInexistente, err := repo.UpdateSolicitacao(ctx, inputInexistente)
	if err != nil {
		t.Fatalf("Erro ao testar solicitaão inexistente: %v", err)
	}

	if payloadInexistente.Status {
		t.Errorf("Esperado status=false para solicitacão inexistente, obteve true")
	}
}