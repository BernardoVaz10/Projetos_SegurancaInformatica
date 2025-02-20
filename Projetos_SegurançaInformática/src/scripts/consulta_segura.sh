#!/bin/bash

# Definir caminhos para os ficheiros encriptados e as chaves
declare -A ficheiros
ficheiros["user_grupo_72_78_alto"]="/dados/alto_grupo_72_78/confidencial_72_78.txt.enc"
ficheiros["user_grupo_72_78_medio"]="/dados/médio_grupo_72_78/intermediario_72_78.txt.enc"
ficheiros["user_grupo_72_78_baixo"]="/dados/baixo_grupo_72_78/publico_72_78.txt.enc"

declare -A chaves
chaves["user_grupo_72_78_alto"]="/chaves_grupo_72_78/user_grupo_72_78_alto_private.pem"
chaves["user_grupo_72_78_medio"]="/chaves_grupo_72_78/user_grupo_72_78_medio_private.pem"
chaves["user_grupo_72_78_baixo"]="/chaves_grupo_72_78/user_grupo_72_78_baixo_private.pem"

# Obter o nome do utilizador atual
utilizador=$(whoami)

# Verificar se o utilizador tem permissão para aceder ao ficheiro
if [[ -z "${ficheiros[$utilizador]}" ]]; then
    echo "❌ Acesso negado! Não tens permissão para consultar este ficheiro."
    exit 1
fi

# Solicitar a passphrase
echo "🔐 Introduz a tua passphrase para desencriptar os dados:"
read -s passphrase

# Desencriptar o ficheiro e mostrar os dados
openssl rsautl -decrypt -inkey "${chaves[$utilizador]}" -passin pass:$passphrase -in "${ficheiros[$utilizador]}"
if [[ $? -ne 0 ]]; then
    echo "❌ Erro ao desencriptar! Verifica se a passphrase está correta."
else
    echo "✅ Dados desencriptados com sucesso!"
fi
