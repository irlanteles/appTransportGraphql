#!/bin/bash
TOKEN=$(curl -s -X POST http://172.19.0.2:8083/login -H "Content-Type: application/json" -d '{"usuario":"irlan.pinho","password":"123456","sistema":"Transporte"}' | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token obtido: ${TOKEN:0:30}..."
curl -s -X POST http://localhost:8080/query -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"query":"mutation { updateSolicitacao(input: { solicitacao_id: 59111, solicitacao_situacao: 1, solicitacao_st: 1, solicitacao_kminicial: \"1200\", solicitacao_kmfinal: \"1250\" }) { status mensagem solicitacao { solicitacao_id solicitacao_situacao solicitacao_st solicitacao_kminicial solicitacao_kmfinal solicitacao_dt_alteracao } } }"}'
echo ""
