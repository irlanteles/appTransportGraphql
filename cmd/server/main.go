package main

import (
	"log"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/irlanteles/api-graphql/graph"
	"github.com/irlanteles/api-graphql/internal/database"
	"github.com/irlanteles/api-graphql/internal/middleware"
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
	passageiroRepo := repositories.NewPassageiroRepository(db)
	roteiroRepo := repositories.NewRoteiroRepository(db)
	solicitacaoRepo := repositories.NewSolicitacaoRepository(db)

	// Inicialização dos Serviços
	checklistService := services.NewChecklistService(checklistRepo)
	checkoutService := services.NewCheckoutService(checkoutRepo)
	viagemService := services.NewViagemService(viagemRepo)
	dashboardService := services.NewDashboardService(dashboardRepo)
	veiculoService := services.NewVeiculoService(veiculoRepo)
	passageiroService := services.NewPassageiroService(passageiroRepo)
	roteiroService := services.NewRoteiroService(roteiroRepo)
	solicitacaoService := services.NewSolicitacaoService(solicitacaoRepo)

	// Carrega a chave pública
	if err := middleware.LoadPublicKey("keys/public_key.pem"); err != nil {
		log.Fatalf("Erro ao carregar chave pñblica: %v", err)
	}

	// Configuração dos GraphQL
	srv := handler.NewDefaultServer(graph.NewExecutableSchema(graph.Config{
		Resolvers: &graph.Resolver{
			ChecklistService:   checklistService,
			CheckoutService:    checkoutService,
			ViagemService:     viagemService,
			DashboardService:  dashboardService,
			VeiculoService:     veiculoService,
			PassageiroService:  passageiroService,
			RoteiroService:    roteiroService,
			SolicitacaoService: solicitacaoService,
		},
	}))

	mux := http.NewServeMux()
	mux.Handle("/", playground.Handler("GraphQL playground", "/query"))
	mux.Handle("/query", srv)

	// Applica o middleware em todas as rotas
	handlerComAutenticacao := middleware.AuthMiddleware(mux)

	log.Printf("Conectado a http://0.0.0.0:%s/ no GraphQL Playground (acessævel via rede local)", port)
	log.Fatal(http.ListenAndServe("0.0.0.0:"+port, handlerComAutenticacao))
}
