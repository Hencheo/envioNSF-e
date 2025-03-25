# Guia Rápido de Configuração do Sistema de Envio de NFS-e

Este guia apresenta os passos essenciais para configurar e utilizar o Sistema de Envio de NFS-e.

## 1. Requisitos

Antes de iniciar, certifique-se que seu sistema atende aos seguintes requisitos:

- Python 3.8 ou superior instalado
- Driver ODBC do SQL Server instalado
- Banco de dados SQL Server acessível
- Certificado digital A1 válido (para ambiente de produção)

## 2. Instalação

1. Clone o repositório ou baixe os arquivos do sistema:
```
git clone https://github.com/Hencheo/envioNSF-e.git
cd envioNSF-e
```

2. Instale as dependências necessárias:
```
pip install -r requirements.txt
```

3. Execute o script para criar a estrutura do banco de dados:
   - Abra o arquivo `criar_banco_nfse.sql` no SQL Server Management Studio (SSMS)
   - Execute os blocos de código sequencialmente conforme instruções no arquivo

## 3. Primeira Execução

Execute o sistema pela primeira vez:
```
python run.py
```

## 4. Configuração do Sistema

### 4.1. Configurações Iniciais

Na primeira execução, você precisará configurar:

1. **Banco de Dados**:
   - Clique em "Configurar Manualmente" na tela inicial
   - Na aba "Banco de Dados", preencha:
     - Driver ODBC: Selecione o driver do SQL Server
     - Servidor: Nome ou IP do servidor de banco de dados
     - Banco de Dados: NFSe_DB (ou o nome que você escolheu)
     - Método de Autenticação: Windows ou SQL Server
     - Usuário e Senha (se usar autenticação SQL Server)
   - Clique em "Testar Conexão" para verificar

2. **WebService**:
   - Na aba "WebService", preencha:
     - URLs do WebService (fornecidas pela prefeitura)
     - Namespace XML (padrão ABRASF ou da prefeitura)
     - Credenciais de acesso (fornecidas pela prefeitura)
     - Certificado Digital: Caminho para o arquivo .pfx ou .p12
     - Senha do Certificado Digital

3. **Configurações Gerais**:
   - Na aba "Geral", configure:
     - Diretórios para XMLs e logs
     - Timeout e número de tentativas de envio

4. Clique em "Salvar" para finalizar a configuração

### 4.2. Importar Configurações

Se você já possui um arquivo de configuração:

1. Clique em "Importar Configurações" na tela inicial
2. Selecione o arquivo de configuração JSON
3. O sistema carregará as configurações automaticamente

## 5. Utilizando o Sistema

### 5.1. Transmitir RPS

1. Na aba "Transmitir RPS":
   - Selecione o período desejado ou deixe em branco para ver todas as RPS
   - Clique em "Buscar RPS" para listar as RPS pendentes
   - Marque as RPS que deseja transmitir
   - Clique em "Transmitir Selecionadas"

2. Acompanhe o progresso da transmissão:
   - O sistema exibirá uma barra de progresso
   - Ao finalizar, mostrará um relatório com os resultados

### 5.2. Consultar NFS-e

1. Na aba "Consultar NFS-e":
   - Selecione o período desejado ou deixe em branco para ver todas as notas
   - Clique em "Buscar NFS-e" para listar as notas já transmitidas
   - Use os botões para visualizar detalhes ou baixar XMLs das notas

## 6. Modo de Simulação

Quando o sistema está em modo de simulação:
- Um aviso é exibido na barra de status
- As operações funcionam normalmente, mas nada é enviado ao servidor real
- Útil para treinamento e testes

Para sair do modo de simulação:
1. Configure um certificado digital válido
2. Reinicie o sistema

## 7. Solução de Problemas

### 7.1. Problemas de Conexão com Banco de Dados

- Verifique se o servidor está acessível
- Confirme se o nome do banco de dados está correto
- Verifique as credenciais de acesso
- Teste a conexão usando uma ferramenta externa como SSMS

### 7.2. Problemas com o Certificado Digital

- Verifique se o caminho para o certificado está correto
- Confirme se a senha do certificado está correta
- Verifique se o certificado está dentro da validade
- Tente importar o certificado para o Windows e use-o a partir daí

### 7.3. Erros de Transmissão

- Verifique os logs em logs/nfse_[data].log
- Confirme se as URLs do WebService estão corretas
- Verifique se o servidor da prefeitura está online
- Valide os dados das RPS que estão sendo transmitidas

## 8. Backup e Exportação

- Faça backups regulares do banco de dados
- Exporte suas configurações pela opção "Exportar Config"
- Mantenha um backup do seu certificado digital em local seguro

## Suporte Técnico

Para obter suporte técnico, entre em contato através do repositório do GitHub:
https://github.com/Hencheo/envioNSF-e