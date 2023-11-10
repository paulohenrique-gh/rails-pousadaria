# Pousadaria

Versão Ruby: 3.2.1

Versão Rails: 7.1.1

Instalar dependências:
```
bundle install
```

Criar o banco de dados:
```
rails db:migrate
```

Iniciar o servidor:
```
rails server
```

Porta padrão: [3000](http://localhost:3000)


## Características

### Cadastro de dono de pousada
- Usuáro pode criar conta como dono de pousada com e-mail e senha

### Cadastro de pousada
- Usuário autenticado como dono de pousada deve cadastrar pousada informando:
  - Nome fantasia
  - Razão social
  - CNPJ
  - Telefone para contato
  - E-mail
  - Endereço completo
  - Horário padrão para check-in
  - Horário padrão para check-out
  - Opcionais:
    - Descrição
    - Formas de pagamento
    - Permissão para pets
    - Políticas de uso
- Apenas o dono da pousada é capaz de editar os dados de uma pousada
- É permitida apenas uma pousada por usuário com perfil de proprietário
- Usuário consegue indicar sua pousada está ativa ou não na plataforma
- Pousadas inativas não são listadas e não aceitam novas reservas
- Usuário dono de pousada tem apenas a página de cadastro de pousada e a opção de logout liberadas. Enquanto não tiver pousada cadastrada, será redirecionado para a página de cadastro.

### Cadastro de quartos
- Usuário autenticado como douno de pousada pode adicionar quartos a uma pousada informando:
  - Nome do quarto
  - Descrição
  - Dimensão em m²
  - Quantidade máxima de pessoas
  - Valor padrão da diária 
  - Possui ou não banheiro próprio
  - Possui ou não varanda
  - Possui ou não ar condicionado
  - Possui ou não TV
  - Possui ou não guarda-roupas
  - Possui ou não cofre
  - Acessível para pessoas com deficiência ou não
- Apenas o usuário dono da pousada tem acesso a adicionar e editar quartos em sua pousada
- O dono da pousada consegue indicar se o quarto está disponível ou não para reservas. Quartos indisponíveis não são listados para o usuário final
- Cadastro de quarto é feito com vinculação automática à pousada e ao usuário proprietário, garantindo que não seja necessário informar esses dados no formulário, e que o quarto não seja vinculado a outro usuário

### Preços por período
- Usuário autenticado como dono de pousada pode definir preços por período para os quartos, permitindo que o valor da diária mude de acordo com o período
- O cadastro do preço é vinculado ao quarto da pousada e deve possuir:
  - Data de início
  - Data final
  - Valor da diária no período
- Não é permitida sobreposição de datas. Ao tentar incluir período em que a data inicial ou final esteja dentro de outro período já cadastrado, o cadastro não é concluído
- O dono da pousada tem acesso à lista de preços por período na tela de detalhes do quarto
- Não é possível editar preço por período, apenas inativar

### Listagem de pousadas
- Usuário não autenticado visualiza todas as pousadas cadastradas e ativas na aplicação
- As pousadas são listadas em 2 blocos: 
  - 3 pousadas mais recentes
  - Outras pousadas
- Cada pousada é listada com seu nome fantasia e cidade
- Cada pousada listada possui um link para a página com seus detalhes
- Usuário visitante não visualiza razão social e CNPJ da pousada na página de detalhes

### Pousadas por cidade
- Usuário não autenticado tem acesso na tela inicial a um menu com cidades que tem pousada cadastrada
- Ao clicar no nome da cidade, o usuário é direcionado para uma lista das pousadas disponíveis naquela cidade, em ordem alfabética pelo nome fantasia
- Cada pousada na lista tem um link para sua página de detalhes

### Busca de pousadas
- Usuário não autenticado tem acesso a um campo de busca de pousadas
- A busca pode ser feita pelo nome fantasia, pelo bairro ou pela cidade
- A tela de resultados exibe a quantidade de registros encontrados, o termo utilizado na pesquisa, e uma lista em ordem alfabética pelo nome fantasia
- Cada pousada na lista tem um link para sua página de detalhes
- **TODO**: Página de pesquisa avançada

### Visualização dos quartos
- Usuário não autenticado consegue visualizar todos os quartos disponíveis na página de detalhes de uma pousada
- Para cada quarto listado são exibidas as informações cadastradas, com exceção da lista de preços por período, que apenas o proprietárioi consegue acessar


## Referências

Algumas páginas de documentação e artigos que tem ajudado

- [Nested Attributes](https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
- [Capybara Cheatsheet](https://www.campuscode.com.br/conteudos/capybara-cheatsheet)
- [Associations](https://guides.rubyonrails.org/association_basics.html#detailed-association-reference)
- [Strong Parameters](https://api.rubyonrails.org/classes/ActionController/StrongParameters.html)
- [RSpec Helper Specs](https://rspec.info/features/6-0/rspec-rails/helper-specs/helper-spec/)
- [Nested Resources](https://guides.rubyonrails.org/routing.html#nested-resources)
- [Action View Number Helpers](https://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#)
- [Reload](https://dpericich.medium.com/using-activerecords-reload-method-to-keep-attributes-current-652504427fc7)
- [Pluck](https://guides.rubyonrails.org/v5.1/active_record_querying.html#pluck)
- [Join](https://guides.rubyonrails.org/active_record_querying.html#joining-tables)
- [```compact_blank```](https://edgeapi.rubyonrails.org/classes/ActionController/Parameters.html#method-i-compact_blank)
- [```delete_if```](https://edgeapi.rubyonrails.org/classes/ActionController/Parameters.html#method-i-delete_if)