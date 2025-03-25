# Sistema de Envio de NFS-e

Sistema para emissão e envio de Notas Fiscais de Serviço Eletrônicas (NFS-e) para prefeituras através de WebServices.

## Funcionalidades

- Interface gráfica para gerenciamento de emissões de NFS-e
- Configuração simplificada de conexão com banco de dados
- Envio de lotes de RPS para conversão em NFS-e
- Consulta e acompanhamento de notas emitidas
- Suporte a certificado digital A1
- Armazenamento e visualização de XMLs
- Log detalhado de operações

## Requisitos

- Python 3.8 ou superior
- Módulos Python listados em `requirements.txt`
- Banco de dados SQL Server
- Certificado digital A1 válido (para ambiente de produção)

## Instalação

1. Clone o repositório:
```
git clone https://github.com/Hencheo/envioNSF-e.git
cd envioNSF-e
```

2. Instale as dependências:
```
pip install -r requirements.txt
```

3. Execute o programa:
```
python -m app.main
```

## Configuração

Ao iniciar o programa pela primeira vez, será necessário configurar:

### Banco de Dados
- Driver ODBC para SQL Server
- Servidor e nome do banco de dados
- Credenciais de acesso (autenticação Windows ou SQL Server)

### WebService
- URLs de envio e consulta
- Configurações de autenticação do WebService
- Certificado digital A1 (.pfx ou .p12)

### Configurações Gerais
- Diretórios para armazenamento de XMLs e logs
- Timeout e número de tentativas de envio

## Como Usar

1. Inicie o programa
2. Configure a conexão com o banco de dados através do menu "Arquivo > Configurações"
3. Na aba "Transmitir RPS", selecione o período e clique em "Buscar RPS"
4. Marque as RPS que deseja transmitir e clique em "Transmitir Selecionadas"
5. Acompanhe as notas transmitidas na aba "Consultar NFS-e"

## Modo Simulação

Caso não tenha um certificado digital configurado, o sistema funcionará em modo de simulação, permitindo testar todas as funcionalidades sem efetivamente enviar as notas.

## Suporte

Para dúvidas ou problemas, entre em contato através do repositório do GitHub.