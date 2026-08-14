Atue como desenvolvedor Go especialista em GraphQL com gqlgen e PostgreSQL.

Preciso atualizar uma mutation existente da minha API GraphQL. Antes de alterar qualquer código, analise a estrutura atual do projeto, principalmente:

- schema GraphQL;
- mutations existentes;
- resolvers;
- models gerados pelo gqlgen;
- camada de acesso ao banco;
- repositories/services, caso existam;
- padrão utilizado atualmente para tratamento de erros;
- padrão utilizado para conexão e execução de queries no PostgreSQL.

Não crie uma arquitetura paralela se o projeto já possuir um padrão definido. Siga o padrão existente.

## Objetivo

A mutation deve permitir atualizar uma solicitação existente na tabela:

`transporte.solicitacao`

A solicitação deve ser identificada obrigatoriamente pelo campo:

`solicitacao_id`

Os campos que a mutation deve permitir atualizar são:

- `solicitacao_situacao`
- `solicitacao_saida_dt`
- `solicitacao_retorno_dt`
- `solicitacao_st`
- `solicitacao_kminicial`
- `solicitacao_kmfinal`

## Estrutura da tabela

A tabela possui a seguinte definição relevante:

```sql
CREATE TABLE transporte.solicitacao (
    solicitacao_id int4 DEFAULT nextval('transporte.seq_solicitacao_veiculo'::text::regclass) NOT NULL,
    solicitacao_solicitante int4 NOT NULL,
    solicitacao_qtdpessoa varchar NULL,
    tipo_veiculo_id int4 NOT NULL,
    solicitacao_roteiro_ds text NULL,
    solicitacao_obs text NULL,
    solicitacao_dt date NULL,
    solicitacao_hr varchar NULL,
    solicitacao_saida_dt_prevista timestamp NULL,
    solicitacao_retorno_dt_prevista timestamp NULL,
    solicitacao_motorista int4 NULL,
    veiculo_id int4 NULL,
    solicitacao_saida_dt timestamp NULL,
    solicitacao_retorno_dt timestamp NULL,
    solicitacao_unidadecusto int4 NOT NULL,
    solicitacao_situacao numeric(1) DEFAULT 0 NULL,
    solicitacao_st numeric(1) DEFAULT 0 NULL,
    solicitacao_dt_criacao date NULL,
    solicitacao_dt_alteracao date NULL,
    solicitacao_devolvida numeric(1) DEFAULT 0 NULL,
    solicitacao_kminicial varchar NULL,
    solicitacao_kmfinal varchar NULL,
    solicitacao_obs_gestor varchar(255) NULL,
    solicitacao_infor_pendencia varchar(255) NULL,
    solicitacao_solicitante_est int4 NULL,
    solicitacao_numero varchar(10) NULL,
    projeto_cd int2 DEFAULT 2000 NOT NULL,
    acao_cd int2 DEFAULT 9999 NOT NULL,
    territorio_cd int2 DEFAULT 99 NOT NULL,
    fonte_cd int2 DEFAULT 109 NOT NULL,
    convenio_id int4 DEFAULT 0 NULL,
    socilitacao_numero_diaria int4 DEFAULT 0 NULL,
    socilitacao_endereco_maps varchar(512) DEFAULT '0' NULL,
    endereco_origem_id int4 NULL
);
```

## Requisitos da mutation

Crie ou ajuste a mutation existente para receber:

1. `solicitacao_id` — obrigatório;
2. os campos que devem ser atualizados.

A mutation deve executar um `UPDATE` na tabela `transporte.solicitacao`, utilizando `solicitacao_id` no `WHERE`.

O comportamento esperado é equivalente a:

```sql
UPDATE transporte.solicitacao
SET
    solicitacao_situacao = $1,
    solicitacao_saida_dt = $2,
    solicitacao_retorno_dt = $3,
    solicitacao_st = $4,
    solicitacao_kminicial = $5,
    solicitacao_kmfinal = $6,
    solicitacao_dt_alteracao = CURRENT_DATE
WHERE solicitacao_id = $7;
```

Porém, não copie essa implementação cegamente. Adapte-a ao padrão de acesso ao banco já utilizado no projeto.

## Atualização parcial

Analise a implementação atual do GraphQL e determine se o projeto já utiliza inputs opcionais/pointers para mutations parciais.

Se utilizar, mantenha esse padrão.

A mutation deve permitir atualizar somente os campos enviados, sem sobrescrever campos não informados.

Por exemplo, se somente `solicitacao_situacao` e `solicitacao_st` forem enviados, os demais campos não devem ser alterados.

Se o projeto atualmente trabalha com todos os campos obrigatórios em mutations de atualização, explique isso antes de alterar o comportamento.

## Tipos dos campos

Respeite os tipos existentes no PostgreSQL:

- `solicitacao_id`: `int4`
- `solicitacao_situacao`: `numeric(1)`
- `solicitacao_saida_dt`: `timestamp`
- `solicitacao_retorno_dt`: `timestamp`
- `solicitacao_st`: `numeric(1)`
- `solicitacao_kminicial`: `varchar`
- `solicitacao_kmfinal`: `varchar`

Não altere o DDL da tabela.

Não converta `solicitacao_kminicial` ou `solicitacao_kmfinal` para número, pois no banco esses campos são `varchar`.

Para os campos de data/hora, utilize o tipo já adotado pelo projeto para representar `timestamp`.

## Retorno

Analise como as mutations existentes retornam dados.

Preferencialmente, a mutation deve retornar a solicitação atualizada, caso isso seja compatível com o padrão atual da API.

Depois do UPDATE, obtenha os dados atualizados utilizando `solicitacao_id` e retorne o objeto GraphQL correspondente.

Não faça um SELECT desnecessário se a implementação atual do projeto já possuir uma forma adequada de retornar os dados atualizados.

## Validações

Implemente pelo menos as seguintes validações:

- `solicitacao_id` deve ser obrigatório;
- verificar se a solicitação existe;
- se não existir, retornar um erro apropriado;
- não permitir atualizar uma solicitação diferente daquela informada pelo `solicitacao_id`;
- tratar corretamente valores `NULL` quando forem permitidos pelo schema/banco;
- tratar erros do PostgreSQL sem expor detalhes internos desnecessários ao cliente.

Não invente regras de negócio para `solicitacao_situacao` ou `solicitacao_st` sem verificar se elas já existem no projeto.

## Segurança e banco

Utilize queries parametrizadas.

Não monte SQL concatenando valores recebidos pelo GraphQL.

Não utilize:

```go
fmt.Sprintf(...)
```

para inserir valores da requisição diretamente na query SQL.

Utilize os mecanismos de parametrização já existentes no projeto.

Não altere configurações de banco, pool de conexões ou Docker sem necessidade para essa tarefa.

## gqlgen

Depois de alterar o schema GraphQL, execute a geração do gqlgen conforme o padrão existente no projeto.

Verifique se os arquivos gerados foram atualizados corretamente.

Não edite manualmente arquivos gerados pelo gqlgen se eles forem regenerados automaticamente.

## Compatibilidade

Preserve a compatibilidade com a estrutura atual da API.

Não altere:

- nomes de tabelas;
- nomes das colunas;
- tipos do PostgreSQL;
- relacionamentos existentes;
- outras mutations;
- queries existentes;
- regras não relacionadas a esta tarefa.

## Testes

Depois da implementação:

1. compile a aplicação;
2. execute `gqlgen generate` se necessário;
3. verifique se não existem erros de compilação;
4. execute os testes existentes;
5. se o projeto ainda não possuir testes para essa mutation, crie testes seguindo o padrão já utilizado no projeto.

Teste pelo menos:

- atualização de todos os campos;
- atualização de apenas alguns campos;
- `solicitacao_id` inexistente;
- valores `NULL` quando permitidos;
- erro de banco;
- retorno correto da solicitação atualizada.

## Importante

Antes de modificar o código, faça uma análise da implementação atual e identifique exatamente quais arquivos precisam ser alterados.

Ao finalizar, informe:

1. quais arquivos foram alterados;
2. o que foi alterado em cada arquivo;
3. qual é a assinatura final da mutation GraphQL;
4. um exemplo de chamada GraphQL;
5. quais validações foram implementadas;
6. quais testes foram executados;
7. se houve alguma decisão técnica necessária devido à arquitetura existente.

Não faça alterações fora do escopo desta tarefa.