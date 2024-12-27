# Atividade Prática: Criar e Configurar Ambiente Linux no Windows com WSL e Script de Monitoramento do Nginx

## Objetivo
Realizar a instalação e configuração do Ubuntu no Windows utilizando o WSL, preparar um servidor Nginx e criar um script automatizado para monitorar o status do serviço.

---

## Parte 1: Criando o Ambiente Linux no Windows
### Passos
1. **Habilitar o WSL no Windows:**  
   Durante minha experiência, segui os passos abaixo e passei por cada uma das etapas e erros descritos:
   
   - Abra o PowerShell como administrador e execute o comando:
     ```bash
     wsl --install
     ```
   - O Windows solicitou que eu reiniciasse o sistema. Após a reinicialização, recebi o erro `Wsl/WSL_E_WSL_OPTIONAL_COMPONENT_REQUIRED`. Para corrigir, executei o comando:
     ```bash
     wsl.exe --install --no-distribution
     ```
   - Após rodar o comando acima, reiniciei o sistema novamente.

   - Em seguida, verifiquei o estado do WSL e as distribuições disponíveis utilizando:
     ```bash
     wsl --list --verbose
     wsl.exe --list --online
     ```
   - Para instalar o Ubuntu 20.04, utilizei o seguinte comando:
     ```bash
     wsl.exe --install Ubuntu-20.04
     ```
   - Durante a instalação, configurei o sistema definindo o **NEW UNIX USERNAME** e o **NEW PASSWORD** conforme solicitado.
   
   - Após concluir a instalação, confirmei que o sistema estava funcionando com:
     ```bash
     uname -a
     ```

2. **Configurar o Ambiente Linux:**  
   - No terminal do Ubuntu, finalizei a configuração inicial, definindo o nome de usuário e senha.

   - Atualizei os pacotes do sistema utilizando:
     ```bash
     sudo apt update && sudo apt upgrade -y
     ```
     > **Nota:** A opção `-y` serve para confirmar automaticamente todas as perguntas com "sim" durante o processo de instalação ou atualização.

   ### Dica para outros usuários:
   - Certifique-se de verificar os requisitos do sistema no site oficial do [WSL](https://learn.microsoft.com/pt-br/windows/wsl/install) antes de iniciar.
   - Se encontrar erros adicionais, revalide as configurações do BIOS para garantir que a virtualização esteja ativada.

### Referências
- [Documentação Oficial do WSL](https://learn.microsoft.com/pt-br/windows/wsl/install)  
- [Ubuntu no WSL](https://ubuntu.com/desktop/wsl)  
- [Vídeo Tutorial no YouTube](https://www.youtube.com/watch?v=_Wp2nWtTBBY)

---
![imagem-prompt-wsl-1](https://github.com/user-attachments/assets/8dbb9e73-ec43-4e01-b570-0a8e9fa82c59)
![imagem-prompt-wsl-2](https://github.com/user-attachments/assets/f3a2e5dd-3b89-4b49-b552-5a5cdcba1dea)
![imagem-prompt-wsl-3](https://github.com/user-attachments/assets/6a6fbf22-8234-4805-a83a-7bfe3d00b0c3)

## Parte 2: Configuração do Nginx  

### Instalar o Nginx  
1. **No terminal do Ubuntu, executei:**  
   ```bash
   sudo apt install nginx -y
   ```  
2. **Verifiquei se o Nginx estava rodando com:**  
   ```bash
   sudo systemctl status nginx
   ```  
   - *Nota:* Caso o serviço não esteja rodando, tente reiniciá-lo com `sudo systemctl restart nginx`.  
---
### Configurar Firewall e Verificar Conexão  
3. **Verifiquei o status do firewall:**  
   ```bash
   sudo ufw status
   ```  
   - *Resultado:* O firewall estava inativo.  
4. **Ativei o firewall com:**  
   ```bash
   sudo ufw enable
   ```  
5. **Confirmei novamente o status do firewall:**  
   ```bash
   sudo ufw status
   ```  
6. **Configurei as regras do firewall para permitir conexões completas do Nginx:**  
   ```bash
   sudo ufw allow "Nginx Full"
   ```  
   - *Nota:* Use `sudo ufw delete allow "Nginx Full"` se precisar remover essa permissão no futuro.  
7. **Verifiquei meu IP público para acessar remotamente o servidor:**  
   ```bash
   curl ifconfig.me
   ```  
   - *Nota:* Se não conseguir acessar pelo IP público, confirme se sua máquina está conectada à rede certa e que o firewall permite conexões externas.  
---
### Teste da Conexão  
8. **Acesse o endereço no navegador:**  
   - Para confirmar que o servidor está ativo, utilizei o endereço [http://localhost](http://localhost) no navegador.

   - *Nota:* Caso esteja em um ambiente remoto, substitua "localhost" pelo IP público obtido no passo 7.  
---
![imagem-prompt-wsl-ngnix-1](https://github.com/user-attachments/assets/f5fa859c-dc77-43ea-8994-6176c428665a)
![imagem-prompt-wsl-ngnix-2](https://github.com/user-attachments/assets/5d2e45c6-9406-4b98-b63f-6f4149209900)
![imagem-prompt-wsl-ngnix-3](https://github.com/user-attachments/assets/56e03c03-235f-4968-a5af-ceea540a189e)
![imagem-prompt-wsl-ngnix-4](https://github.com/user-attachments/assets/b652e500-ba8d-4ca3-8c66-b53309ea4479)
![imagem-prompt-wsl-ngnix-5](https://github.com/user-attachments/assets/2014d1a8-4195-4cef-82a6-f966c2452434)


### Criar o Script de Monitoramento

### 1. Criando o Script

Para criar o arquivo, usei o comando abaixo:
```bash
cat > scriptnginx.sh
```
Em seguida, inseri o seguinte código no terminal e finalizei pressionando `Ctrl+D` para salvar o conteúdo no arquivo:

```bash
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

echo "$datahora - $servico - $status - $mensagem" >> "$arquivo_saida"
```
---

### 2. Tornando o Script Executável

Depois de criar o arquivo, tornei o script executável com o comando:
```bash
chmod +x scriptnginx.sh
```
---

### 3. Executando o Script e Conferindo a Saída

Para rodar o script, usei:
```bash
./scriptnginx.sh
```

Se o Nginx estava funcionando corretamente, o script gerou um arquivo de log chamado `nginx_online.log`, com uma mensagem como:
```text
2024-12-15 16:18:35 - Nginx - ONLINE - O serviço Nginx está online.
```
---

### 4. Organizando os Arquivos

Após criar e executar o script, decidi organizar os arquivos. Criei uma pasta chamada `scripts` e movi o script e os arquivos de log para ela:
```bash
mkdir scripts
mv scriptnginx.sh ./scripts
mv nginx_online.log ./scripts
```
Depois, naveguei até a pasta e conferi os arquivos:
```bash
cd scripts
ls
```
A saída mostrou os arquivos organizados:
```bash
nginx_online.log scriptnginx.sh
```
---

![imagem-prompt-wsl-ngnix-6](https://github.com/user-attachments/assets/2d676e78-7237-4c3e-8657-1661491e1890)
![imagem-prompt-wsl-ngnix-7](https://github.com/user-attachments/assets/8b6f66e9-5a14-4e55-ad53-6161c36d0309)

---
### Automatizando a Execução do Script

Depois de criar e testar o script, decidi automatizar sua execução para que ele fosse executado automaticamente a cada 5 minutos. Aqui estão os passos que segui:

1. Abri o editor do crontab usando o comando:
   ```bash
   crontab -e
   ```
   Foi minha primeira vez usando o crontab no sistema, então ele pediu para selecionar um editor. Escolhi o editor padrão e continuei.

2. No final do arquivo, adicionei a seguinte linha:
   ```bash
   */5 * * * * /caminho/para/scriptnginx.sh
   ```
   Substituí `/caminho/para/` pelo caminho absoluto onde o script estava salvo (no meu caso, dentro da pasta `scripts`).

3. Salvei o arquivo e confirmei que o crontab estava configurado corretamente ao listar as tarefas agendadas com:
   ```bash
   crontab -l
   ```

Agora o script é executado automaticamente a cada 5 minutos e grava as informações no arquivo de log.

![image](https://github.com/user-attachments/assets/9c36dd5a-c5cc-4b60-ba5e-96c9344dbc23)

---
### Versionando o Script com Git

Para garantir que meu script estivesse salvo e versionado corretamente, configurei um repositório Git no meu diretório de projeto. Segui os passos abaixo:

1. Inicializei o repositório Git:
   ```bash
   git init
   ```
   Esse comando criou o repositório dentro da pasta onde estavam o script e os arquivos relacionados.

2. Adicionei o arquivo do script ao repositório e fiz meu primeiro commit:
   ```bash
   git add scriptnginx.sh
   git commit -m "Adicionado script de monitoramento do Nginx"
   ```

3. Configurei um repositório remoto no GitHub para armazenar meu projeto. Usei o seguinte comando para vinculá-lo:
   ```bash
   git remote add origin https://github.com/marcelemontalvao/lablinux.git
   ```

4. Por fim, enviei o commit para o repositório remoto com:
   ```bash
   git push -u origin main
   ```
---
