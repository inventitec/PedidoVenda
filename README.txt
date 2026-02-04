Sistema de Pedido de Venda – Delphi

Projeto desenvolvido como "Teste técnico para vaga de Desenvolvedor Delphi", com foco em boas práticas, organização de código, regras de negócio e usabilidade.

O sistema realiza o cadastro de pedidos de venda, permitindo selecionar clientes, incluir produtos, editar itens e gravar o pedido de forma transacional.

---

Tecnologias Utilizadas

- Delphi 10.3 Rio
- Firebird 2.5
- VCL
- SQL
- Arquitetura em camadas:
  - Model
  - Repository
  - Service
  - View

Banco de Dados

- Banco de dados: Firebird 2.5
- Arquivo: pedidos.fdb

Tabelas
- CLIENTE
- PRODUTO
- PEDIDO
- PEDIDO_ITEM

O banco utiliza Generators (Sequences) e Triggers para controle de chaves primárias.

O script SQL completo para criação do banco está incluído no projeto.

Configuração do Ambiente

Instalação do Firebird
- Instale o Firebird 2.5 (Server ou Embedded).

Criação do Banco
- Crie o banco pedidos.fdb
- Execute o script SQL fornecido para criar as tabelas, sequences e triggers.

Configuração da Conexão
- A conexão com o banco de dados é realizada através de um arquivo de configuração (Config.ini).
- As informações de conexão (caminho do banco, usuário e senha) são lidas na inicialização do sistema.
- O acesso ao banco é feito por meio de um DataModule (DM), utilizando o componente de conexão DB.
- Para executar o projeto, ajuste o arquivo Config.ini conforme o ambiente local.

Executar o Projeto
- Abra o projeto no Delphi 10.3
- Compile e execute

Funcionalidades

Pedido de Venda
- Seleção de cliente através do código
- Busca automática dos dados do cliente
- Inclusão de itens no pedido:
  - Produto
  - Quantidade
  - Valor unitário (editável)
- Grid de itens com:
  - Código do produto
  - Descrição
  - Quantidade
  - Valor unitário
  - Total do item
- Total do pedido calculado automaticamente
- Gravação do pedido com seus respectivos itens

Usabilidade

- ENTER funciona como TAB para navegação entre campos
- ENTER no grid permite editar o item selecionado
- DEL no grid remove o item selecionado
- Campos numéricos formatados automaticamente com 2 casas decimais
- Feedback visual e mensagens de validação ao usuário

Arquitetura do Projeto

Model
- Contém as classes de domínio:
  - TCliente
  - TProduto
  - TPedido
  - TPedidoItem

Repository
- Responsável exclusivamente pelo acesso ao banco de dados
- Nenhuma regra de negócio é aplicada nesta camada

Service
- Contém as regras de negócio do sistema
- Exemplo:
  - Adicionar item ao pedido
  - Remover item
  - Cálculo de totais

View
- Camada de interface (VCL)
- Responsável apenas por interação com o usuário
- Não acessa banco diretamente

Validações implementadas
- Cliente obrigatório para gravação do pedido
- Pedido deve possuir ao menos um item
- Produto válido
- Quantidade e valor unitário formatados corretamente
- Quantidade e valor unitário não aceitando valores menores que zero.
- Recalculo automático do total ao:
  - Inserir item
  - Editar item
  - Excluir item

Fluxo básico de uso
1. Informe o código do cliente
2. Confirme os dados carregados automaticamente
3. Informe o código do produto
4. Ajuste quantidade e valor unitário, se necessário
5. Clique em Inserir / Atualizar Item
6. Repita para outros produtos
7. Clique em Gravar Pedido
