
# Projeto de Segurança Informática

## Introdução
Este projeto foi desenvolvido com o intuito de demonstrar a implementação de um sistema de segurança baseado no modelo Bell-LaPadula. O modelo Bell-LaPadula é utilizado para controlar o acesso a informações sensíveis, garantindo que os dados sejam protegidos de acessos não autorizados.

## Propósito e Objetivo
O propósito deste projeto é criar um ambiente seguro onde diferentes níveis de usuários (alto, médio e baixo) têm acesso controlado a diretórios e ficheiros específicos. O objetivo é garantir que:
- Usuários de nível baixo não possam acessar dados de níveis médios ou altos.
- Usuários de nível médio não possam acessar dados de níveis altos.
- Usuários de nível alto possam acessar dados de níveis médios e baixos, mas com restrições de escrita.

## Como Usar
1. Clone o repositório para o seu ambiente local.
2. Navegue até o diretório do projeto.
3. Execute o script `comandos.sh` para configurar o ambiente de segurança.
   ```bash
   sudo bash src/comandos.sh
   ```
4. Teste os comandos descritos no ficheiro `resultados_testes.txt` para verificar as permissões de acesso.
5. Utilize o script `consulta_segura.sh` para desencriptar e acessar os dados conforme o nível de permissão do usuário.
   ```bash
   sudo -u user_grupo_72_78_medio /usr/local/bin/consulta_segura.sh
   ```

## Como Funciona
- **Configuração de Diretórios e Permissões:** O script `comandos.sh` cria diretórios e ficheiros para diferentes níveis de segurança, define permissões de acesso e gera chaves criptográficas para cada usuário.
- **Encriptação de Dados:** Os ficheiros de dados são encriptados utilizando chaves públicas específicas para cada nível de segurança.
- **Desencriptação de Dados:** O script `consulta_segura.sh` solicita a passphrase do usuário e utiliza a chave privada correspondente para desencriptar e exibir os dados.

## Conclusão
Este projeto demonstra a implementação prática de um modelo de segurança baseado no Bell-LaPadula, garantindo que os dados sejam acessados apenas por usuários autorizados conforme o seu nível de permissão. Através da encriptação e controle de acesso, é possível proteger informações sensíveis de acessos não autorizados.

## Autores
- Bernardo Vaz
- Alessandro Aguiar
