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

- Usuário pode se registrar como proprietário e cadastrar sua pousada
- Usuário não autenticado pode visualizar pousadas disponíveis e seus detalhes
- Proprietário da pousada pode adicionar quartos
- Proprietário da pousada pode cadastrar preços diferentes e mudar o valor da diária de acordo com o período

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