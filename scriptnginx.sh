#!/bin/bash

datahora=$(date +"%Y-%m-%d %H:%M:%S")
servico="Nginx"

if systemctl status nginx | grep "active (running)"; then
  status="ONLINE"
  mensagem="O serviço Nginx está online."
  arquivo_saida="nginx_online.log"
else
  status="OFFLINE"
  mensagem="O serviço Nginx está offline."
  arquivo_saida="nginx_offline.log"
fi

echo "$datahora - $servico - $status - $mensagem" >> "/home/ec2-user/lablinux/$arquivo_saida"