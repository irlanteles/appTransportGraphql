package repositories

import (
	"database/sql"
	"fmt"
)

type ViagemRepository struct {
	db *sql.DB
}

func NewViagemRepository(db *sql.DB) *ViagemRepository {
	return &ViagemRepository{db: db}
}

// Criar chamada para f_inserir_viagem()
func (r *ViagemRepository) InserirViagem(
	solicitacaoSolicitante int,
	solicitacaoQtdpessoa string,
	tipoVeiculoId int,
	enderecos []string,
	solicitacaoRoteiroDs string,
	solicitacaoObs string,
	solicitacaoDt string,
	solicitacaoHr string,
	solicitacaoSaidaDtPrevista string,
	solicitacaoRetornoDtPrevista string,
	solicitacaoUnidadeCusto int,
	solicitacaoSituacao int,
	solicitacaoSt int,
	solicitacaoDtCriacao string,
	solicitacaoSolicitanteEst int,
	projetoCd int,
	acaoCd int,
	territorioCd int,
	fonteCd int,
	solicitacaoNumero string,
	quantidadePessoa int,
	passageiroIds []int,
	ordem int,
) error {
	
	// Utiliza string array syntax para PostgreSQL
	// No pq e pgx podemos usar o type mapping padrão, mas em pg 8 pode ser complexo.
	// Vamos passar arrays no formato '{val1,val2}'
	
	// Por simplicidade, utilizando standard array syntax
	var pEnderecos string = "{"
	for i, e := range enderecos {
		if i > 0 {
			pEnderecos += ","
		}
		pEnderecos += "\"" + e + "\""
	}
	pEnderecos += "}"

	var pPassageiros string = "{"
	for i, p := range passageiroIds {
		if i > 0 {
			pPassageiros += ","
		}
		pPassageiros += fmt.Sprintf("%d", p)
	}
	pPassageiros += "}"

	query := `
		SELECT transporte.f_inserir_viagem(
			$1, $2, $3, $4::text[], $5, $6, $7::date, $8, $9::timestamp, $10::timestamp,
			$11, $12, $13, $14::date, $15, $16, $17, $18, $19, $20, $21, $22::int[], $23
		)
	`
	
	_, err := r.db.Exec(query,
		solicitacaoSolicitante, solicitacaoQtdpessoa, tipoVeiculoId, pEnderecos, solicitacaoRoteiroDs,
		solicitacaoObs, solicitacaoDt, solicitacaoHr, solicitacaoSaidaDtPrevista, solicitacaoRetornoDtPrevista,
		solicitacaoUnidadeCusto, solicitacaoSituacao, solicitacaoSt, solicitacaoDtCriacao, solicitacaoSolicitanteEst,
		projetoCd, acaoCd, territorioCd, fonteCd, solicitacaoNumero, quantidadePessoa, pPassageiros, ordem,
	)

	return err
}
