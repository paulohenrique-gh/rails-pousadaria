# API

URL Base: http://localhost:3000/api/v1/

## Recursos

### Listagem de pousadas
Retorna uma lista completa das pousadas cadastradas e ativas na plataforma. É possível filtrar as pousadas utilizando o parâmetro ```search```, passando um nome de pousada. Em caso de não haver pousadas cadastradas ou não ser encontrada pousada com o nome passado na busca, será retornada uma lista vazia.

**Método**: ```GET```

**Endpoint**: ```/guesthouses```

**Parâmetro opcional**:
- ```search``` - Termo de busca para filtrar pousadas pelo nome

**Exemplo sem parâmetro de busca**

- **Requisição**:
  ```
  http://localhost:3000/api/v1/guesthouses
  ```

- **Resposta**:
  ```json
  [
    {
      "id": 1,
      "brand_name": "Boa Vista",
      "phone_number": "1133334444",
      "email": "pousada1@mail.com",
      "description": "Pousada com uma boa vista",
      "pet_policy": true,
      "guesthouse_policy": "Proibido som alto",
      "checkin_time": "14:00",
      "checkout_time": "10:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 1",
        "number": "111",
        "complement": "Térreo",
        "neighbourhood": "Conjunto 1",
        "city": "São Paulo",
        "state": "SP",
        "postal_code": "11111-111"
      }
    },
    {
      "id": 2,
      "brand_name": "Descanso",
      "phone_number": "2133334444",
      "email": "pousada2@mail.com",
      "description": "Finalmente sossego",
      "pet_policy": true,
      "guesthouse_policy": "Proibido bebidas alcoólicas",
      "checkin_time": "13:30",
      "checkout_time": "11:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 2",
        "number": "222",
        "complement": "Térreo",
        "neighbourhood": "Conjunto 2",
        "city": "Rio de Janeiro",
        "state": "RJ",
        "postal_code": "22222-222"
      }
    },
    {
      "id": 3,
      "brand_name": "Pousada Natureza",
      "phone_number": "3133334444",
      "email": "pousada3@mail.com",
      "description": "Pousada próximo ao Parque Nacional",
      "pet_policy": true,
      "guesthouse_policy": "Proibido som alto",
      "checkin_time": "14:30",
      "checkout_time": "11:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 3",
        "number": "333",
        "complement": "Térreo",
        "neighbourhood": "Conjunto 3",
        "city": "Belo Horizonte",
        "state": "MG",
        "postal_code": "33333-333"
      }
    }
  ]
  ```

**Exemplo com parâmetro de busca**

- Requisição:
  ```
  http://localhost:3000/api/v1/guesthouses/?search=descanso
  ```
- Resposta:
  ```json
  [
    {
      "id": 2,
      "brand_name": "Descanso",
      "phone_number": "2133334444",
      "email": "pousada2@mail.com",
      "description": "Finalmente sossego",
      "pet_policy": true,
      "guesthouse_policy": "Proibido bebidas alcoólicas",
      "checkin_time": "13:30",
      "checkout_time": "11:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 2",
        "number": "222",
        "complement": "Térreo",
        "neighbourhood": "Conjunto 2",
        "city": "Rio de Janeiro",
        "state": "RJ",
        "postal_code": "22222-222"
      }
    }
  ]
  ```

---

### Listagem de quartos de uma pousada

Retorna uma lista com os quartos disponíveis em uma pousada a partir do ID dela. Se a pousada ainda não possuir quartos cadastrados, será retornada uma lista vazia.

**Método**: ```GET```

**Endpoint**: ```/guesthouses/:guesthouse_id/rooms```

**Exemplos**:
- Requisição
  ```
  http://localhost:3000/api/v1/guesthouses/1/rooms
  ```

- Resposta
  ```json
  [
    {
      "id": 1,
      "name": "Quarto 1",
      "description": "Quarto com tema 1",
      "dimension": 100,
      "max_people": 2,
      "daily_rate": 150,
      "private_bathroom": true,
      "balcony": false,
      "air_conditioning": true,
      "tv": true,
      "closet": false,
      "safe": false,
      "accessibility": false,
      "available": true,
      "guesthouse_id": 1
    },
    {
      "id": 2,
      "name": "Quarto 2",
      "description": "Quarto com tema 2",
      "dimension": 50,
      "max_people": 2,
      "daily_rate": 40,
      "private_bathroom": true,
      "balcony": false,
      "air_conditioning": false,
      "tv": true,
      "closet": true,
      "safe": false,
      "accessibility": true,
      "available": true,
      "guesthouse_id": 1
    }
  ]
  ```
---

### Detalhes de uma pousada

Retorna um JSON com os detalhes de uma pousada, incluindo a média de avaliações, a partir de seu ID

**Método**: ```GET```

**Endpoint**: ```/guesthouses/:guesthouse_id```

**Exemplos**:
- Requisição
  ```
  http://localhost:3000/api/v1/guesthouses/1
  ```

- Resposta
  ```json
  {
    "id": 1,
    "brand_name": "Boa Vista",
    "phone_number": "1133334444",
    "email": "pousada1@mail.com",
    "description": "Pousada com uma boa vista",
    "pet_policy": true,
    "guesthouse_policy": "Proibido som alto",
    "checkin_time": "14:00",
    "checkout_time": "10:00",
    "payment_method_one": "Dinheiro",
    "payment_method_two": "Pix",
    "payment_method_three": "Cartão",
    "address": {
      "street_name": "Rua 1",
      "number": "111",
      "complement": "Térreo",
      "neighbourhood": "Conjunto 1",
      "city": "São Paulo",
      "state": "SP",
      "postal_code": "11111-111"
    },
    "average_rating": 4.75
  }
  ```  
---

### Consulta de disponibilidade

Consulta disponibilidade de um quarto de acordo com os parâmetros passados na requisição, e retorna o valor da reserva se o quarto estiver disponível. Caso o quarto não esteja disponível, é retornada apenas a mensagem de erro.

**Método**: ```GET```

**Endpoint**: ```/api/v1/rooms/:room_id/check_availability```

**Parâmetros obrigatórios**: 
  - ```checkin``` - Data de início da estadia. Formato: ```YYYY-MM-DD``` (exemplo: 2023-11-24)
  - ```checkout``` - Data de término da estadia. Formato: ```YYYY-MM-DD``` (exemplo: 2023-11-30)
  - ```guest_count``` - Quantidade de hóspedes. Não deve ultrapassar a capacidade máxima do quarto, nem ser menor que 1

**Exemplos**
- Requisição
  ```
  http://localhost:3000/api/v1/rooms/7/check_availability/?checkin=2023-12-20&checkout=2023-12-25&guest_count=2
  ```
- Resposta
  ```json
  {
    "stay_total": 3600.0
  }
  ```
---

### Listagem de cidades

Retorna uma lista com os nomes das cidades onde há pousada ativa na aplicação. É possível filtrar as pousadas com o parâmetro ```city```, passando um nome de cidade. Caso não haja pousadas disponíveis na cidade informada, será retornada uma lista vazia.

**Método**: ```GET```

**Endpoint**: ```/api/v1/guesthouses/cities```

**Parâmetro opcional**:
- ```city``` - Termo para filtrar pousadas pelo nome da cidade

**Exemplo sem filtro**

- **Requisição**:
  ```
  http://localhost:3000/api/v1/guesthouses/cities
  ```

- **Resposta**:
  ```json
  [
    {
      "city_name": "Fortaleza"
    },
    {
      "city_name": "Limoeiro do Norte"
    },
    {
      "city_name": "São Paulo"
    }
  ]
  ```

**Exemplo com filtro**

- **Requisição**:
  ```
  http://localhost:3000/api/v1/guesthouses/cities/?city=fortaleza
  ```

- **Resposta**:
  ```json
  [
    {
      "id": 1,
      "brand_name": "Praia Calma",
      "phone_number": "8533332222",
      "email": "praiacalma@mail.com",
      "description": "Pousada próximo à Beira-Mar",
      "pet_policy": true,
      "guesthouse_policy": "Proibido som alto",
      "checkin_time": "11:30",
      "checkout_time": "16:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 1",
        "number": "111",
        "complement": "Térreo",
        "neighbourhood": "Beira-mar",
        "city": "Fortaleza",
        "state": "CE",
        "postal_code": "60600-600"
      }
    },
    {
      "id": 2,
      "brand_name": "Paz Divina",
      "phone_number": "8598552555",
      "email": "pousada2@mail.com",
      "description": "Pousada tranquila",
      "pet_policy": true,
      "guesthouse_policy": "Proibido som alto",
      "checkin_time": "06:30",
      "checkout_time": "16:00",
      "payment_method_one": "Dinheiro",
      "payment_method_two": "Pix",
      "payment_method_three": "Cartão",
      "address": {
        "street_name": "Rua 2",
        "number": "222",
        "complement": "Térreo",
        "neighbourhood": "Antônio Bezerra",
        "city": "Fortaleza",
        "state": "CE",
        "postal_code": "60999-999"
      }
    }
  ]
  ```




