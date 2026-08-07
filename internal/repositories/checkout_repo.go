package repositories

import (
	"database/sql"
	"github.com/irlanteles/api-graphql/graph/model"
)

type CheckoutRepository struct {
	db *sql.DB
}

func NewCheckoutRepository(db *sql.DB) *CheckoutRepository {
	return &CheckoutRepository{db: db}
}

func (r *CheckoutRepository) Inserir(c *model.CheckoutInput) (int, error) {
	query := `
		INSERT INTO transporte.checkout (
			idsolicitacao, limpezaexterior, exteriordetalhes, limpezainterior, interiordetalhes,
			niveloleomotor, niveloleodirecao, niveloleofreio, nivelaguaradiador,
			lampadas, chaveroda, macaco, triangulo, extintor, tapetes, nivelcombustivel, estepe,
			observacoes, status, buzina, placa, data_hora_real, setas, ocorrencia, acidente,
			barulho, motor, descricaoincidentes
		) VALUES (
			$1, $2, $3, $4, $5, $6, $7, $8, $9, 
			$10, $11, $12, $13, $14, $15, $16, $17,
			$18, $19, $20, $21, $22, $23, $24, $25,
			$26, $27, $28
		) RETURNING id
	`

	var id int
	err := r.db.QueryRow(query,
		c.IDSolicitacao, c.LimpezaExterior, c.ExteriorDetalhes, c.LimpezaInterior, c.InteriorDetalhes,
		c.NivelOleoMotor, c.NivelOleoDirecao, c.NivelOleoFreio, c.NivelAguaRadiador,
		c.Lampadas, c.ChaveRoda, c.Macaco, c.Triangulo, c.Extintor, c.Tapetes, c.NivelCombustivel, c.Estepe,
		c.Observacoes, c.Status, c.Buzina, c.Placa, c.DataHoraReal, c.Setas, c.Ocorrencia, c.Acidente,
		c.Barulho, c.Motor, c.DescricaoIncidentes,
	).Scan(&id)

	if err != nil {
		return 0, err
	}
	return id, nil
}
