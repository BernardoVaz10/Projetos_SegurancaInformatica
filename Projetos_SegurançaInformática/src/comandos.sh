#!/bin/bash

# Entrar no modo root para executar comandos administrativos
sudo -i

# Criar os diretórios para armazenar os dados conforme os níveis de segurança
mkdir -p /dados/alto_grupo_72_78
mkdir -p /dados/médio_grupo_72_78
mkdir -p /dados/baixo_grupo_72_78

# Criar ficheiros de exemplo para cada nível de segurança
echo -e "Nome1 - 12345\nNome2 - 67890" > /dados/alto_grupo_72_78/confidencial_72_78.txt
echo -e "Nome1 - 12345\nNome2 - 67890" > /dados/médio_grupo_72_78/intermediario_72_78.txt
echo -e "Nome1 - 12345\nNome2 - 67890" > /dados/baixo_grupo_72_78/publico_72_78.txt

# Criar utilizadores para cada nível de segurança
sudo useradd -m user_grupo_72_78_alto
sudo useradd -m user_grupo_72_78_medio
sudo useradd -m user_grupo_72_78_baixo

# Criar grupos de acesso
sudo groupadd grupo_72_78_alto
sudo groupadd grupo_72_78_medio
sudo groupadd grupo_72_78_baixo

# Adicionar os utilizadores aos seus respetivos grupos
sudo usermod -aG grupo_72_78_alto user_grupo_72_78_alto
sudo usermod -aG grupo_72_78_medio user_grupo_72_78_medio
sudo usermod -aG grupo_72_78_baixo user_grupo_72_78_baixo

# Ajustar permissões de acesso aos diretórios conforme Bell-LaPadula
sudo chown -R root:grupo_72_78_alto /dados/alto_grupo_72_78
sudo chmod 770 /dados/alto_grupo_72_78

sudo chown -R root:grupo_72_78_medio /dados/médio_grupo_72_78
sudo chmod 750 /dados/médio_grupo_72_78

sudo chown -R root:grupo_72_78_baixo /dados/baixo_grupo_72_78
sudo chmod 755 /dados/baixo_grupo_72_78

# Bloquear escrita de níveis superiores nos diretórios de menor privilégio
sudo chmod 550 /dados/médio_grupo_72_78
sudo chmod 555 /dados/baixo_grupo_72_78

# Testar as permissões
sudo -u user_grupo_72_78_medio ls /dados/alto_grupo_72_78
sudo -u user_grupo_72_78_baixo ls /dados/médio_grupo_72_78
sudo -u user_grupo_72_78_alto touch /dados/médio_grupo_72_78/teste.txt
sudo -u user_grupo_72_78_medio touch /dados/baixo_grupo_72_78/teste.txt

# Criar diretório para armazenar chaves criptográficas
sudo mkdir -p /chaves_grupo_72_78
sudo chmod 700 /chaves_grupo_72_78
sudo chown seed:seed /chaves_grupo_72_78

# Gerar chaves privadas e públicas para cada utilizador
openssl genrsa -aes256 -passout pass:passphrasea -out /chaves_grupo_72_78/user_grupo_72_78_alto_private.pem 2048
openssl rsa -in /chaves_grupo_72_78/user_grupo_72_78_alto_private.pem -passin pass:passphrasea -pubout -out /chaves_grupo_72_78/user_grupo_72_78_alto_public.pem
sudo chmod 600 /chaves_grupo_72_78/user_grupo_72_78_alto_private.pem
sudo chmod 644 /chaves_grupo_72_78/user_grupo_72_78_alto_public.pem

openssl genrsa -aes256 -passout pass:passphrasem -out /chaves_grupo_72_78/user_grupo_72_78_medio_private.pem 2048
openssl rsa -in /chaves_grupo_72_78/user_grupo_72_78_medio_private.pem -passin pass:passphrasem -pubout -out /chaves_grupo_72_78/user_grupo_72_78_medio_public.pem
sudo chmod 600 /chaves_grupo_72_78/user_grupo_72_78_medio_private.pem
sudo chmod 644 /chaves_grupo_72_78/user_grupo_72_78_medio_public.pem

openssl genrsa -aes256 -passout pass:passphraseb -out /chaves_grupo_72_78/user_grupo_72_78_baixo_private.pem 2048
openssl rsa -in /chaves_grupo_72_78/user_grupo_72_78_baixo_private.pem -passin pass:passphraseb -pubout -out /chaves_grupo_72_78/user_grupo_72_78_baixo_public.pem
sudo chmod 600 /chaves_grupo_72_78/user_grupo_72_78_baixo_private.pem
sudo chmod 644 /chaves_grupo_72_78/user_grupo_72_78_baixo_public.pem

# Encriptar os ficheiros de dados para cada nível de segurança
openssl rsautl -encrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_alto_public.pem -pubin -in /dados/alto_grupo_72_78/confidencial_72_78.txt -out /dados/alto_grupo_72_78/confidencial_72_78.txt.enc
openssl rsautl -encrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_medio_public.pem -pubin -in /dados/médio_grupo_72_78/intermediario_72_78.txt -out /dados/médio_grupo_72_78/intermediario_72_78.txt.enc
openssl rsautl -encrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_baixo_public.pem -pubin -in /dados/baixo_grupo_72_78/publico_72_78.txt -out /dados/baixo_grupo_72_78/publico_72_78.txt.enc

# Remover os ficheiros originais para garantir segurança
sudo rm /dados/alto_grupo_72_78/confidencial_72_78.txt
sudo rm /dados/médio_grupo_72_78/intermediario_72_78.txt
sudo rm /dados/baixo_grupo_72_78/publico_72_78.txt

# Testar a desencriptação dos ficheiros
echo "Testando acesso aos arquivos desencriptados:"
openssl rsautl -decrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_alto_private.pem -passin pass:passphrasea -in /dados/alto_grupo_72_78/confidencial_72_78.txt.enc -out ~/confidencial_72_78_decrypted.txt
openssl rsautl -decrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_medio_private.pem -passin pass:passphrasem -in /dados/médio_grupo_72_78/intermediario_72_78.txt.enc -out ~/intermediario_72_78_decrypted.txt
openssl rsautl -decrypt -inkey /chaves_grupo_72_78/user_grupo_72_78_baixo_private.pem -passin pass:passphraseb -in /dados/baixo_grupo_72_78/publico_72_78.txt.enc -out ~/publico_72_78_decrypted.txt

# Exibir o conteúdo dos ficheiros desencriptados
cat ~/confidencial_72_78_decrypted.txt
# Saída esperada:
# Nome1 - 12345
# Nome2 - 67890

# Exibindo o conteúdo do arquivo intermediário descriptografado
cat ~/intermediario_72_78_decrypted.txt
# Saída esperada:
# Nome1 - 12345
# Nome2 - 67890

# Exibindo o conteúdo do arquivo público descriptografado
cat ~/publico_72_78_decrypted.txt
# Saída esperada:
# Nome1 - 12345
# Nome2 - 67890

# Criar ou editar o script de consulta restrita
sudo nano /usr/local/bin/consulta_segura.sh

# Tornar o script de consulta restrita executável
sudo chmod +x /usr/local/bin/consulta_segura.sh

# Testar o script de consulta restrita com o utilizador medio
sudo -u user_grupo_72_78_medio /usr/local/bin/consulta_segura.sh