#!/bin/bash

datahora=$(date +"%Y-%m-%d %H:%M:%S")
servico="Nginx"

if systemctl status nginx | grep "active (running)"; then
  status="ONLINE"
  mensagem="O serviço Nginx está ativo e em execução normalmente."
  arquivo_saida="nginx_online.log"
else
  status="OFFLINE"
  mensagem="O serviço Nginx não está em execução atualmente."
  arquivo_saida="nginx_offline.log"
fi

echo "$datahora - $servico - $status - $mensagem" >> "$arquivo_saida"


