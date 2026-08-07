package main

import (
	"log"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/irlanteles/api-graphql/graph"
	"github.com/irlanteles/api-graphql/internal/database"
	"github.com/irlanteles/api-graphql/internal/repositories"
	"github.com/irlanteles/api-graphql/internal/services"
)

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	db, err := database.Connect()
	if err != nil {
		log.Fatalf("Erro ao conectar no banco de dados: %v", err)
	}
	defer db.Close()

	// Inicialização dos Repositórios
	checklistRepo := repositories.NewChecklistRepository(db)
	checkoutRepo := repositories.NewCheckoutRepository(db)
	viagemRepo := repositories.NewViagemRepository(db)
	dashboardRepo := repositories.NewDashboardRepository(db)
	veiculoRepo := repositories.NewVeiculoRepository(db)

	// Inicialização dos Serviços
	checklistService := services.NewChecklistService(checklistRepo)
	checkoutService := services.NewCheckoutService(checkoutRepo)
	viagemService := services.NewViagemService(viagemRepo)
	dashboardService := services.NewDashboardService(dashboardRepo)
	veiculoService := services.NewVeiculoService(veiculoRepo)

	// Configuração do GraphQL
	srv := handler.NewDefaultServer(graph.NewExecutableSchema(graph.Config{
		Resolvers: &graph.Resolver{
			ChecklistService: checklistService,
			CheckoutService:  checkoutService,
			ViagemService:    viagemService,
			DashboardService: dashboardService,
			VeiculoService:   veiculoService,
		},
	}))

	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)

	log.Printf("Conectado a http://0.0.0.0:%s/ no GraphQL Playground (acessível via rede local)", port)
	log.Fatal(http.ListenAndServe("0.0.0.0:"+port, nil))
}
