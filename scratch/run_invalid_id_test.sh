#!/bin/bash
TOKEN=$(curl -s -X POST http://172.19.0.2:8083/login -H "Content-Type: application/json" -d '{"usuario":"irlan.pinho","password":"123456","sistema":"Transporte"}' | grep -o '"token":"[^"]*' | cut -d'"' -f4)
curl -s -X POST http://localhost:8080/query -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"query":"mutation { updateSolicitacao(input: { solicitacao_id: 99999999, solicitacao_kminicial: \"1300\" }) { status mensagem solicitacao { solicitacao_id } } }"}'
echo ""
