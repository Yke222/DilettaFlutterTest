

# Ecommerce Flutter App

Este é um aplicativo Flutter que simula um ecommerce, permitindo que os usuários visualizem os produtos, favorite e adicionem ao carrinho verificando o valor total do pedido.

## Funcionalidades

- Login
    - Local
- Listagem dos produtos
    - Dois tipos de visualizacao (Grid e Lista)
    - Listagem infinita
    - API da Vtex
- Favoritos
    - Adicionar
    - Remover
- Carrinho
    - Adicionar
    - Remover
- Filtros/Ordenação:
    - Preco decrescente
    - Preco crescente
    - Ordem alfabetica decrescente
    - Ordem alfaberica crescente
    - Melhor desconto
- Busca
    - Busca de todos os produtos a partir de uma palavra chave.

Foi utilizada a [API da Vtex](https://developers.vtex.com/docs/api-reference/search-api#get-/api/catalog_system/pub/products/search/-search-?endpoint=get-/api/catalog_system/pub/products/search/-search-) (uma das maiores engines de ecommerce do brasil, que consta com milhares de clientes) para o desafio usei a loja de suplementos Integralmedica.

O Login foi feito de forma local para facilitar tanto o desenvolvimento (evitando fluxo de cadastro, esqueceu senha...) e o teste, com isso, qualquer email e senha informado na tela de Login sera aceito, a partir do email fazemos a persistencia dos favoritos e carrinho, ou seja, caso você entre com um email X e favorite N produtos, ao entrar novamente com esse email, ira ser exibido os mesmos produtos, caso voce entre com outro email ira trazer os produtos relacionado ao email informado.

PS: Funcional em todas as plataformas que o Flutter realiza o build: Android, iOS, Web e Desktop.

## Capturas de Tela


## Pré-requisitos

Certifique-se de ter o Flutter instalado em sua máquina. Você pode seguir as instruções de instalação no [site oficial do Flutter](https://flutter.dev/docs/get-started/install).

Após o Flutter instalado, basta executar o projeto.

PS: Versão do Flutter utilizada para o desenvolvimento: 3.13.4

## Dependências

Foram adicionadas as seguintes dependências:

- **flutter_bloc**: Esse foi o gerenciador de estado escolhido para esta aplicação. Permite definir um estado e trabalhar com variações deles de forma organizada.

- **result_dart**: Utilizado para trabalhar com retornos duplos, um para sucesso e outro para falha, simplificando o mapeamento de erros e exceções.

- **dio**: Utilizado para realizar chamadas HTTP.

- **shared_preferences**: Utilizado para armazenar de forma local a lista de produtos favoritados e adicionado ao carrinho.

- **provider**: Utilizado para prover instancias a partir de um widget pai e seus filhos.

- **cached_network_image**: Utilizado para fazer um cache das imagens dos produtos exibidos na listagem, fazendo com que a aplicacao tenha um desempenho e uma fluidez melhor.