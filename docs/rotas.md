# Documentação de Rotas da API Transporte

O acesso aos dados é feito via GraphQL. Existe apenas um endpoint (rota) principal de operação e um para acesso ao Playground para testes.

## Endpoint Base

- **Desenvolvimento (Local)**: `http://localhost:8080/query`
- **Playground (Interface Gráfica)**: `http://localhost:8080/`

---

## Configurações

O banco de dados, porta e credenciais são definidos via variáveis de ambiente (arquivo `.env`):

- `DB_NAME`: Nome do banco (ex: dev)
- `DB_USER`: Usuário (ex: gestor)
- `DB_PASSWORD`: Senha
- `DB_HOST`: Host (default: localhost)
- `DB_PORT`: Porta (default: 5432)
- `PORT`: Porta de serviço da API (default: 8080)

O ambiente roda nativamente conectando num banco **PostgreSQL**. Garantimos compatibilidade tanto com a versão 8.x (produção) quanto versões superiores.

---

## Operações GraphQL (Queries e Mutations)

### 1. Dashboard (Query)

Retorna as informações para o dashboard do motorista.

**GraphQL:**
```graphql
query {
  dashboard(idMotorista: "15") {
    motorista {
      id
      nome
      placa
    }
    viagens {
      numeroSolicitacao
      paradas {
        data
        horario
        solicitante
        autorizado
        origem
        destino
      }
    }
  }
}
```

### 2. Checklist (Mutation)

Realiza a inserção de um registro de checklist de veículo.

**GraphQL:**
```graphql
mutation {
  checklist(input: {
    id_solicitacao: "123",
    limpeza_exterior: 1,
    nivel_oleo_motor: 1,
    # ... demais campos
  }) {
    id
    mensagem
    status
  }
}
```

### 3. Checkout (Mutation)

Realiza a inserção de um registro de checkout.

**GraphQL:**
```graphql
mutation {
  checkout(input: {
    id_solicitacao: "123",
    limpeza_exterior: 1,
    nivel_oleo_motor: 1,
    # ... demais campos
  }) {
    id
    mensagem
    status
  }
}
```

### 4. Criar Viagem (Mutation)

Aciona a função de banco `transporte.f_inserir_viagem()` passando os parâmetros da solicitação.

**GraphQL:**
```graphql
mutation {
  criarViagem(input: {
    solicitacao_solicitante: 10,
    solicitacao_qtdpessoa: "2",
    tipo_veiculo_id: 1,
    enderecos: ["Matriz", "Filial Norte"],
    solicitacao_roteiro_ds: "Rota padrão",
    # ... demais campos
  }) {
    mensagem
    status
  }
}
```

### 5. Veículos (Query)

Retorna a lista de veículos disponíveis (onde `veiculo_st = 0`).

**GraphQL:**
```graphql
query {
  veiculos {
    veiculo_id
    veiculo_placa
    tipo_veiculo_id
    veiculo_st
    veiculo_dt_criacao
    veiculo_tag
    pessoa_id
    hodometro_inicial
    hodometro_final
    tipo_veiculo_ds
    tipo_veiculo_qtd_passageiro
  }
}
```
