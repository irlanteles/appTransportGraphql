Prompt - Desenvolvimento de API GraphQL em Go utilizando gqlgen
Objetivo

Desenvolver uma API GraphQL em Go utilizando o framework gqlgen.

A API será responsável pela comunicação entre aplicações internas e um banco de dados PostgreSQL.

O projeto deve ser desenvolvido pensando em manutenção, performance, testabilidade e baixo acoplamento.

Requisitos técnicos
Linguagem
Go (última versão estável compatível com gqlgen)
Framework
gqlgen
Banco de dados

Durante o desenvolvimento será utilizado:

PostgreSQL 18

Porém o ambiente de produção utiliza:

PostgreSQL 8.x

Este é o requisito mais importante do projeto.

Toda implementação deve ser compatível com ambos.

Isso significa:

Não utilizar recursos exclusivos do PostgreSQL moderno.
Não utilizar JSONB.
Não utilizar GENERATED ALWAYS.
Não utilizar UPSERT (ON CONFLICT).
Não utilizar funções criadas após PostgreSQL 8.
Evitar CTEs caso exista incompatibilidade.
Utilizar SQL ANSI sempre que possível.
Toda consulta deve funcionar igualmente no PostgreSQL 8.

Caso seja necessário algum recurso moderno, ele deverá possuir alternativa compatível com PostgreSQL 8.

Estrutura do projeto

Desejo uma arquitetura organizada em camadas.

Exemplo:

cmd/
server/

graph/
schema.graphqls
resolver.go

internal/

database/
repositories/
services/
models/
dto/
mapper/

config/

pkg/


Separar responsabilidades corretamente.

Os Resolvers do GraphQL não devem conter regras de negócio.

Toda regra deverá ficar na camada Service.

Toda comunicação com banco deverá ficar em Repository.

Banco de dados

O DDL completo será fornecido posteriormente.

A IA deverá gerar os Models utilizando a estrutura do banco.

Não inventar tabelas nem colunas.

Utilizar exatamente o DDL fornecido.

Endpoint (Query) Dashboard

Criar uma Query chamada:

dashboard(idMotorista: ID!)

Ela deverá receber:

idMotorista

Retorno esperado:

nome do motorista
lista de viagens alocadas para ele

Cada motorista poderá possuir uma ou mais viagens.

Cada viagem deverá retornar:

número da solicitação

Cada viagem poderá possuir várias subviagens/paradas.

Cada parada deverá retornar:

data
horário
solicitante
autorizado
origem
destino

Modelo GraphQL esperado:

Dashboard

 ├── motorista
 ├── viagens[]
         ├── numeroSolicitacao
         ├── paradas[]
                  ├── data
                  ├── horario
                  ├── solicitante
                  ├── autorizado
                  ├── origem
                  └── destino
Exemplo de resposta JSON
{
  "data": {
    "dashboard": {
      "motorista": {
        "id": 15,
        "nome": "João da Silva"
      },
      "viagens": [
        {
          "numeroSolicitacao": 5487,
          "paradas": [
            {
              "data": "2026-08-03",
              "horario": "08:30",
              "solicitante": "Maria Oliveira",
              "autorizado": "Carlos Souza",
              "origem": "Matriz",
              "destino": "Filial Norte"
            },
            {
              "data": "2026-08-03",
              "horario": "11:45",
              "solicitante": "Maria Oliveira",
              "autorizado": "Carlos Souza",
              "origem": "Filial Norte",
              "destino": "Cliente ABC"
            }
          ]
        },
        {
          "numeroSolicitacao": 5490,
          "paradas": [
            {
              "data": "2026-08-04",
              "horario": "09:15",
              "solicitante": "Pedro Lima",
              "autorizado": "Ana Costa",
              "origem": "Cliente ABC",
              "destino": "Matriz"
            }
          ]
        }
      ]
    }
  }
}
Mutation Checklist

Criar uma Mutation:

checklist(input: ChecklistInput!)

Ela deverá inserir um checklist no banco.

Campos:

id_solicitacao
limpeza_exterior
exterior_detalhes
limpeza_interior
interior_detalhes
nivel_oleo_motor
nivel_oleo_direcao
nivel_oleo_freio
nivel_agua_radiador
combustivel
lampadas
chave_roda
macaco
triangulo
extintor
tapetes
nivel_combustivel
estepe
observacoes
status
buzina
placa
data_hora_real
setas

Retornar:

id
mensagem
status
Mutation Checkout

Criar uma Mutation:

checkout(input: CheckoutInput!)

Inserir no banco:

id_solicitacao
limpeza_exterior
exterior_detalhes
limpeza_interior
interior_detalhes
nivel_oleo_motor
nivel_oleo_direcao
nivel_oleo_freio
nivel_agua_radiador
combustivel
lampadas
chave_roda
macaco
triangulo
extintor
tapetes
nivel_combustivel
estepe
observacoes
status
buzina
placa
data_hora_real
setas
ocorrencia
acidente
barulho
motor
descricao_incidentes

Retornar:

id
mensagem
status
Mutation Criar Viagem

Criar uma Mutation:

criarViagem(...)

Importante

Já existe uma função responsável por inserir viagens.

A API não deverá recriar esta lógica.

Ela deverá apenas chamar essa função existente, realizando:

validação dos parâmetros;
tratamento de erros;
retorno padronizado em GraphQL.
Boas práticas obrigatórias

A implementação deverá seguir:

Clean Architecture (adaptada ao projeto)
SOLID
Repository Pattern
Service Layer
DTOs
Mappers
Context em todas as operações
Tratamento de erros centralizado
Logs estruturados
Configuração por variáveis de ambiente
Código documentado
Separação entre Models do banco e tipos GraphQL
Evitar lógica de negócio nos Resolvers
Evitar SQL duplicado
Preparar a aplicação para futura autenticação via middleware GraphQL
Compatibilidade com PostgreSQL 8

Antes de gerar qualquer SQL, verificar se ele é compatível com PostgreSQL 8.

Caso alguma instrução não seja compatível, utilizar uma implementação alternativa.

O objetivo é que a aplicação funcione sem alterações tanto no PostgreSQL 18 (desenvolvimento) quanto no PostgreSQL 8.x (produção).

Fluxo esperado de desenvolvimento
Aguardar o DDL completo do banco de dados.
Gerar os Models com base no DDL.
Criar o schema GraphQL (schema.graphqls).
Gerar os Resolvers utilizando o gqlgen.
Implementar os Repositories.
Implementar os Services.
Implementar as Mutations e Queries.
Adicionar tratamento de erros e logs.
Criar exemplos de queries e mutations para testes no GraphQL Playground.
Garantir compatibilidade total com PostgreSQL 8 antes de concluir a implementação.