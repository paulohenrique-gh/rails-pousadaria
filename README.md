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
- Usuário consegue indicar se sua pousada está ativa ou não na plataforma na página de detalhes da pousada
- Pousadas inativas não são listadas e não aceitam novas reservas. Para fazer alterações na pousada, o proprietário tem que reativá-la clicando no botão correspondente na página de detalhes.
- Usuário dono de pousada tem apenas a página de cadastro de pousada e a opção de logout liberadas. Enquanto não tiver pousada cadastrada, será redirecionado para a página de cadastro.

### Cadastro de quartos
- Usuário autenticado como dono de pousada pode, na página de detalhes, adicionar quartos a uma pousada informando:
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
- O link para a página de detalhes do quarto fica disponível apenas para o dono da pousada, na sessão de quartos da página de detalhes 
- O dono da pousada consegue indicar se o quarto está disponível ou não para reservas. Quartos indisponíveis não são listados para o usuário final.
- Cadastro de quarto é feito com vinculação automática à pousada e ao usuário proprietário, garantindo que não seja necessário informar esses dados no formulário, e que o quarto não seja vinculado a outro usuário

### Preços por período
- Usuário autenticado como dono de pousada pode definir preços por período para os quartos, permitindo que o valor da diária mude de acordo com o período
- O cadastro do preço é vinculado ao quarto da pousada e deve possuir:
  - Data de início
  - Data final
  - Valor da diária no período
- Não é permitida sobreposição de datas. Ao tentar incluir período em que a data inicial ou final esteja dentro de outro período já cadastrado, o cadastro não é concluído
- Apenas o dono da pousada tem acesso à lista de preços por período, entrando na tela de detalhes do quarto
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
- As pousadas são listadas mesmo que ainda não possuam quartos castrados

### Busca de pousadas
- Usuário não autenticado tem acesso a um campo de busca de pousadas a partir de qualquer página da aplicação
- Busca rápida:
  - Pode ser feita pelo nome fantasia, pelo bairro ou pela cidade, preenchendo o termo de busca na barra superior e clicando em 'Buscar'
- Busca avançada:
  - Ao lado da barra de busca rápida, o usuário pode clicar num link que direciona para um formulário de pesquisa avançada, com os seguintes campos:
    - Nome da pousada
    - Bairro
    - Cidade
    - Estado
    - Aceita pets
    - Banheiro no quarto
    - Varanda
    - Ar-condicionado
    - TV
    - Guarda-roupas
    - Cofre
    - Acessível para pessoas com deficiência
  - É necessário que pelo menos um campo seja preenchido
- A tela de resultados exibe a quantidade de registros encontrados, os termos utilizados na pesquisa, e uma lista em ordem alfabética pelo nome fantasia
- Cada pousada na lista tem um link para sua página de detalhes
- As pousadas são listadas mesmo que ainda não possuam quartos castrados

### Visualização dos quartos
- Usuário não autenticado consegue visualizar todos os quartos disponíveis na página de detalhes de uma pousada
- Para cada quarto listado são exibidas as informações cadastradas, com exceção da lista de preços por período, que apenas o proprietário consegue acessar entrando no link 'Mais detalhes' na sessão de quartos da página da pousada


### Disponibilidade de quartos
- Visitante sem cadastro pode iniciar a reserva de um quarto através da lista na página de detalhe de uma pousada
- Na página da reserva, o visitante vê os detalhes do quarto e um formulário para informar as datas de checkin e checkout e a quantidade de hóspedes
  - A data de checkout não pode ser menor que a de checkin
  - A quantidade de hóspedes não pode ser negativa, nem exceder o limite do quarto
- Se o quarto estiver disponível no período informado, o usuário ainda não autenticado é informado o valor total da estadia e tem acesso a um botão para confirmação da reserva
  - O valor total é calculado com base no valor padrão da diária e nos preços por períodos cadastrados pelo proprietário
  - As reservas canceladas de um quarto não são consideradas ao validar disponibilidade

### Reservar quarto
- Ao clicar no botão para confirmar a reserva, o visitante ainda não autenticado é direcionado para a página de cadastro, ou login caso já possua conta
- O cadastro de hóspede requer as seguintes informações:
  - Nome completo
  - CPF
  - E-mail
  - Senha
- Após autenticação, o usuário pode confirmar a reserva, que ficará disponível no link "Minhas Reservas" em qualquer página da aplicação
- As reservas são identificadas por um código único de 8 caracteres
- O usuário pode cancelar a reserva até 7 dias antes da data agendada para o check-in

### Check-in
- Usuário dono de pousada consegue visualizar suas reservas através da opção "Reservas" no menu.
- A página de reservas lista todas as reservas da pousada, com os seguintes detalhes:
  - Código da reserva
  - Quarto
  - Responsável pela reserva
  - Data agendada para entrada
  - Data agendada para saída
  - Quantidade de hóspedes
  - Status da reserva
    - Confirmada: reserva agendada e confirmada pelo hóspede
    - Cancelada: reserva cancelada pelo hóspede ou pelo proprietário
    - Estadia ativa: reserva com check-in confirmado pelo proprietário
    - Concluída: reserva com check-out confirmado pelo proprietário 
- O proprietário pode cancelar a reserva a partir de 2 dias após a data agendada para o check-in em caso de não comparecimento do hóspede


## Referências

Algumas páginas de documentação e artigos que tem ajudado

- [Nested Attributes](https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
- [Capybara Cheatsheet](https://www.campuscode.com.br/conteudos/capybara-cheatsheet)
- [Associations](https://guides.rubyonrails.org/association_basics.html#detailed-association-reference)
- [Strong Parameters](https://api.rubyonrails.org/classes/ActionController/StrongParameters.html)
- [RSpec Helper Specs](https://rspec.info/features/6-0/rspec-rails/helper-specs/helper-spec/)
- [Nested Resources](https://guides.rubyonrails.org/routing.html#nested-resources)
- [Action View Number Helpers](https://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#)
- [```reload```](https://dpericich.medium.com/using-activerecords-reload-method-to-keep-attributes-current-652504427fc7)
- [```pluck```](https://guides.rubyonrails.org/v5.1/active_record_querying.html#pluck)
- [```joins```](https://guides.rubyonrails.org/active_record_querying.html#joining-tables)
- [```except```](https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-except)
- [```compact_blank```](https://edgeapi.rubyonrails.org/classes/ActionController/Parameters.html#method-i-compact_blank)
- [```delete_if```](https://edgeapi.rubyonrails.org/classes/ActionController/Parameters.html#method-i-delete_if)
- [Scopes](https://www.campuscode.com.br/conteudos/scope-em-ruby-on-rails)
- [```try```](https://api.rubyonrails.org/classes/NilClass.html#method-i-try)
- [Condicionais com objeto nil](https://franzejr.github.io/best-ruby/refactorings/conditionals_when_object_is_nil.html#)
- [Traduzindo Enums no Rails](https://www.campuscode.com.br/conteudos/traduzindo-enums-no-rails)