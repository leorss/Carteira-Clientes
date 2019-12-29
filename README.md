# Distribuição da carteira de clientes para vendedores novos

### Requisitos :
- Download da IDE [OpenCobol](https://launchpad.net/cobcide/+download)
- Download repositorio do git: `git clone https://github.com/leorss/carteira-clientes.git`
- Compilar os arquivos fontes através da IDE do OpenCobol.
- Instruções de uso no arquivo "manual.docx" localizado no diretorio "documentos"".

### Instruções de acesso :

Executar o programa GCC000P (Menu Principal), presente na pasta bin do projeto. No menu principal, escolher uma das opções apresentadas.

### Mapa do sistema:

    GCC000P - Menu Principal
        1. Cadastros
            1. GCC011P - Cadastro Cliente
                1. Inserir
                2. Atualizar
                3. Exclir
                4. GCC041P - Importação arquivo de Cliente
            2. GCC012P - Cadastro Vendedor
                1. Inserir
                2. Atualizar
                3. Exclir
                4. GCC042P - Importação arquivo de Vendedor
        2. Relatorios
            1. GCC021P - Relatorio Cliente
            2. GCC022P - Relatorio Vendedor
        3. GCC031P - Executar Distribuição de Clientes
