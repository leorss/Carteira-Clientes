# Distribuição da carteira de clientes para vendedores novos

### Requisitos :
- Download da IDE [OpenCobol](https://launchpad.net/cobcide/+download)
- Download repositorio do git: `git clone https://github.com/leorss/carteira-clientes.git`
- Compilar os códigos fonte na IDE do OpenCobol.
- Para maiores detalhes, consultar o arquivo "manual.docx" localizado no diretorio "documentos"".


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
        3. GCC030P - Executar Distribuição de Clientes


### Instruções de acesso :

Executar o programa GCC000P (Menu Principal), presente na pasta bin do projeto. No menu principal, escolher uma das opções apresentadas.

<img src="./Imagens/Tela%20Inicial.jpg" alt="Tela Inicial" style="width:42px;height:42px;border:0;">

### 1.	Cadastros

Na tela de cadastros, deverá ser escolhida uma das opções:

![cadastro-cliente](./Imagens/Tela%20cadastro%20cliente.jpg)

### Opção  <F1>  Incluir

Será apresentada a seguinte tela:

![cadastro-cliente-incluir](./Imagens/Tela%20cadastro%20cliente%20incluir.jpg)


### Opção <F2> Alterar

Antes de realizar a alteração, aparecerá a seguinte tela:

![cadastro-cliente-alterar](./Imagens/Tela%20cadastro%20cliente%20alterar.jpg)


### Opção  <F3> Excluir

 ![cadastro-cliente-excluir](./Imagens/Tela%20cadastro%20cliente%20excluir.jpg)


### Opção  <F4> Importar
Escolher o arquivo de importação e pressionar <Enter>

 ![cadastro-cliente-importar](./Imagens/Tela%20cadastro%20cliente%20importar.jpg)


### 2.	Relatórios

### 1)	Relatório clientes:

Nessa tela é possível escolher: 
•	Arquivo destino 
•	Ordenação 
•	Classificação
•	Código do cliente
•	Razão Social
•	Código do vendedor

![relatorio-cliente](./Imagens/Tela%20relatorio%20cliente.jpg)

O relatório de clientes é gerado no seguinte formato:
 
![relatorio-cliente-resultado](https://github.com/leorss/carteira-clientes/blob/master/Imagens/Tela%20relatorio%20cliente%20resultado.jpg)

### 2)	Relatório vendedor:

Nessa tela é possível escolher: 
•	Arquivo destino 
•	Ordenação 
•	Classificação
•	Código do vendedor

![relatorio-vendedor](./Imagens/Tela%20relatorio%20vendedor.jpg)
 
O relatório de clientes é gerado no seguinte formato:
 
![relatorio-vendedor-resultado](./Imagens/Tela%20relatorio%20vendedor%20resultado.jpg)

### 3.	Executar Distribuição de Clientes
Nessa opção, é possível escolher o arquivo destino de importação. O resultado da execução é um arquivo no formato .csv. 

![distribuicao-clientes](./Imagens/Tela%20distribuicao%20clientes.jpg)
