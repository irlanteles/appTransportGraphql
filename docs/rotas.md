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
  dashboard(idMotorista: 15) {
    motorista {
      id
      nome
    }
    viagens {
      solicitacaoId
      numeroSolicitacao
      roteiroDs
      paradas {
        roteiroId
        dataInicio
        horarioInicio
        dataFinal
        horarioFinal
        ordem
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
    id_solicitacao: 123,
    limpeza_exterior: 1,
    exterior_detalhes: "detalhes",
    limpeza_interior: 1,
    interior_detalhes: "detalhes",
    nivel_oleo_motor: 1,
    nivel_oleo_direcao: 1,
    nivel_oleo_freio: 1,
    nivel_agua_radiador: 1,
    combustivel: 1,
    lampadas: 1,
    chave_roda: 1,
    macaco: 1,
    triangulo: 1,
    extintor: 1,
    tapetes: 1,
    nivel_combustivel: 10.5,
    estepe: 1,
    observacoes: "obs",
    status: 1,
    buzina: 1,
    placa: "ABC1234",
    data_hora_real: "2026-08-11T12:00:00Z",
    setas: 1,
    tipo: 1
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
    id_solicitacao: 123,
    limpeza_exterior: 1,
    exterior_detalhes: "detalhes",
    limpeza_interior: 1,
    interior_detalhes: "detalhes",
    nivel_oleo_motor: 1,
    nivel_oleo_direcao: 1,
    nivel_oleo_freio: 1,
    nivel_agua_radiador: 1,
    combustivel: 1,
    lampadas: 1,
    chave_roda: 1,
    macaco: 1,
    triangulo: 1,
    extintor: 1,
    tapetes: 1,
    nivel_combustivel: 10.5,
    estepe: 1,
    observacoes: "obs",
    status: 1,
    buzina: 1,
    placa: "ABC1234",
    data_hora_real: "2026-08-11T12:00:00Z",
    setas: 1,
    ocorrencia: 1,
    acidente: 1,
    barulho: 1,
    motor: 1,
    descricao_incidentes: "desc",
    pneus: 1,
    niveis_fluidos: 1
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
    solicitacao_obs: "Viagem de diretoria",
    solicitacao_dt: "2026-08-15",
    solicitacao_hr: "08:00",
    solicitacao_saida_dt_prevista: "2026-08-15 08:30:00",
    solicitacao_retorno_dt_prevista: "2026-08-15 18:00:00",
    solicitacao_unidadecusto: 200,
    solicitacao_situacao: 4,
    solicitacao_st: 0,
    solicitacao_dt_criacao: "2026-08-14 10:00:00",
    solicitacao_solicitante_est: 0,
    projeto_cd: 1234,
    acao_cd: 5678,
    territorio_cd: 11,
    fonte_cd: 1,
    solicitacao_numero: "202610",
    quantidade_pessoa: 2,
    passageiro_ids: [45, 46],
    ordem: 1
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

### 6. Passageiros (Query)

Retorna a lista de passageiros de uma determinada solicitação.

**GraphQL:**
```graphql
query {
  passageiros(numeroSolicitacao: "202610") {
    pessoa_id
    pessoa_nm
    solicitacao_id
    passageiro_st
    solicitacao_numero
  }
}
```

### 7. Atualizar Roteiro (Mutation)

Atualiza os campos de um roteiro existente. Todos os campos de atualização são opcionais.

**GraphQL:**
```graphql
mutation {
  updateRoteiro(input: {
    roteiro_id: 1,
    roteiro_st: 2,
    data_hora_inicio: "2026-08-12 14:00:00",
    data_hora_fim: "2026-08-12 15:30:00"
  }) {
    mensagem
    status
  }
}
```

### 8. Atualizar Solicitacao (Mutation)

Atualiza os campos de uma solicitação de viagem (status, km, datas, etc).

**GraphQL:**
```graphql
mutation {
  updateSolicitacao(input: {
    solicitacao_id: 59111,
    solicitacao_situacao: 5,
    solicitacao_saida_dt: "2026-08-14 10:00:00",
    solicitacao_retorno_dt: "2026-08-14 11:30:00",
    solicitacao_kminicial: "15000",
    solicitacao_kmfinal: "15120",
    solicitacao_st: 0
  }) {
    mensagem
    status
    solicitacao {
      solicitacao_id
      solicitacao_situacao
      solicitacao_saida_dt
      solicitacao_retorno_dt
      solicitacao_st
      solicitacao_kminicial
      solicitacao_kmfinal
      solicitacao_dt_alteracao
    }
  }
}
```
