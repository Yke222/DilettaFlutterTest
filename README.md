#  Diletta Store - Diletta Solutions
Olá, eu sou **Pablo Raphael** e este é o desafio do processo seletivo da **Diletta Solutions**.
O projeto consiste em um MVP (Produto Mínimo Viável) de um aplicativo de listagem e manipulação de produtos.

### **Características**:
* Visualização de produtos obtidos através de uma Mock API ([dummyjson.com](https://dummyjson.com/)).
* Ordenação de produtos por ordem alfabética crescente / decrescente.
* Ordenação de produtos por ordem de preço crescente / decrescente.
* Pesquisa de títulos de produtos.
* Indicador de produto em promoção através do ícone 'cifrão' em sua foto.
* Filtragem de produtos para exibição de itens exclusivamente em promoção.
* Indicador de produto desejado através do ícone 'coração' em sua foto.
* Adição/remoção de um produto da lista de desejos ao clicar no indicador em sua foto.
* Filtragem de produtos para exibição de itens exclusivamente na lista de desejos (wishlist).
* Exibição de um resumo, com quantidade e preço de todos os produtos, ao mostrar lista de desejos.
* Persistência de dados local através do Shared Preferences.
* Login e Cadastro através da utilização do Backend-as-a-Service (BaaS) Firebase.
* Indicador de estado logado através da exibição da primeira letra do e-mail do usuário na app bar.
* Indicador de estado deslogado através da exibição de ícone 'pessoa' na app bar.
* Prevenção contra erros, como falta de internet, criação de e-mail existente, etc.
* Exibição de produtos conforme navegação do usuário, para minimizar o custo de processamento e memória.
* Otimização e redução de consultas a bancos de dados e APIs, para minimizar o custo de processamento e memória.
* Animação 'fade in' ao carregar imagem do produto.
* Tema baseado nas cores e logo da Diletta Solutions.

### Ferramentas e padrões utilizados:
- **Clean Architecture + SOLID** - Com o objetivo de melhorar a escalabilidade e legibilidade do projeto, somado ao desacoplamento e modularização das camadas.
  ![Flutter TDD Clean Architecture Course – Explanation & Project Structure](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?ssl=1)
  Nesse projeto as camadas da Clean Architecture são:
1.  *Camada de Pages e Widgets*:
    -   Responsável por apresentar a interface do usuário (UI) ao usuário final.
    -   Inclui widgets, telas, páginas e componentes visuais.
2.  *Camada de Controllers*:
    -   Responsável por controlar a interação do usuário na interface.
    -   Recebe entradas do usuário (eventos) e coordena a comunicação com os casos de uso.
3.  *Camada de Use Cases (Casos de Uso)*:
    -   Contém a lógica de negócios da aplicação.
    -   É independente da UI e dos detalhes de implementação do banco de dados.
    -   Usa repositórios para obter e salvar dados.
4.  *Camada de Repositories*:
    -   Define contratos (interfaces) para acessar dados.
    -   Separa a lógica de acesso a dados das implementações específicas (como API, banco de dados local).
5.  *Camada de Entities (Entidades)*:
    -   Contém os objetos de negócios principais.
    -   Representa o núcleo da lógica de negócios da aplicação.
6.  *Camada de DTOs (Data Transfer Objects)*:
    -   Usada para transferir dados entre a camada de dados (ou fonte de dados) e a camada de casos de uso.
    - Pode ser usada para mapear dados da resposta da API em objetos de entidade.
7.  *Camada de Data Sources (Fontes de Dados)*:
    -   Responsável pela obtenção e persistência de dados.
    -   Inclui implementações específicas, como conexões com API, bancos de dados locais, cache, etc.
- **Gerenciamento de Estado MobX** - Como o gerenciamento de estado foi de livre escolha, optei pelo MobX. Por sua alta robustez e simplicidade. O uso de variáveis observáveis e Observers é de fácil compreensão para os demais desenvolvedores que podem vir a trabalhar no projeto.
- **Injeção de Dependências GetIt** - Para fornecer a cada page e widget as informações e objetos necessários optei pelo GetIt, pela simplicidade e eficácia em cumprir o seu objetivo.

### Versões:
- Flutter  3.10.6 (channel stable)
- Dart 3.0.6

### Observações
- É muito importante que seja utilizada a versão mais recente do Fluter e versão do Dart acima da 3.0. Para isso use no seu terminal o comando `flutter upgrade`.
- Caso tenha problemas ao buildar, não esqueça de executar o `flutter clean` e/ou apagar o `pubspec.lock`.
- Não esqueça que o MobX precisa de seus arquivos auto-gerados. Para garantir um bom funcionamento execute `flutter packages pub run build_runner build` após obter as dependências do `pubspec.yaml`.
- Seguindo o Princípio da Inversão de Dependência do SOLID, Repositórios e Data Sources estão divididos em interfaces e implementações.
- É de meu conhecimento que fazer o upload das informações do Firebase é uma prática não recomendada. Aqui, está sendo feito exclusivamente para fins justos. Por isso após o período do processo seletivo, o Projeto Firebase será excluído, inutilizando os acessos.
- Este README está escrito em português exclusivamente para melhor compreensão dos avaliadores. Porém todo o código continua seguindo o padrão internacional.