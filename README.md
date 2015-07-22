CorreiosSigep
=============

[![Build Status](https://travis-ci.org/duduribeiro/correios_sigep.svg?branch=master)](https://travis-ci.org/duduribeiro/correios_sigep)

- Integrador responsável pela comunicação com o SigepWeb - http://goo.gl/z8VJjJ.
- Excelente documentação do SigepWeb providenciada pelos Correios: http://goo.gl/6TWp2f :trollface:

- Métodos suportados
-- Solicitação de postagem de reversa (documentação, pág 36)
-- Busca de SRO - ticket (documentação, pág 39)

## Instalação

Adicione ao seu Gemfile:

```ruby
gem 'correios_sigep'
```

E execute:

    $ bundle

Ou instale manualmente com:

    $ gem install correios_sigep

## Utilizando

### Configurando
Para utilizar a gem, é necessário configurar os campos necessários com base nos dados contrato com os Correios.

```ruby
CorreiosSigep.configure do |config|
  config.user                   = '60618043'
  config.password               = '8o8otn'
  config.administrative_code    = '08082650'
  config.card                   = '0057018901'
  config.contract               = '9912208555'
  config.service_code           = '41076'
end
```

Se for necessário, é possível adicionar também um proxy.

```ruby
  config.proxy = 'http://px.myproxy.com'
```

### Logistica Reversa

#### Solicitar Postagem Reversa
(pg. 36 da documentação)

```ruby
  recipient = CorreiosSigep::Models::Recipient.new({
    address: 'Endereco',
    area_code: 'DDD',
    city: 'Cidade',
    complement: 'Complemento',
    email: 'Email',
    name: 'Nome',
    neighborhood: 'Bairro',
    number: 'Numero',
    phone: 'Telefone',
    postal_code: 'CEP',
    reference: 'Referencia',
    state: 'Estado'
  })
  sender    = CorreiosSigep::Models::Sender.new({
    address: 'Endereco',
    area_code: 'DDD',
    city: 'Cidade',
    complement: 'Complemento',
    email: 'Email',
    name: 'Nome',
    neighborhood: 'Bairro',
    number: 'Numero',
    phone: 'Telefone',
    postal_code: 'CEP',
    reference: 'Referencia',
    state: 'Estado'
  })
  objects   = [
    {
      item: 'Item',
      id: '1',
      description: 'Descricao',
      num: '',
    },
    {
      item: 'Item',
      id: '2',
      description: 'Descricao',
      num: '',
    }
  ]

  # Produto: pag 67 da documentação oficial dos correios
  product   = CorreiosSigep::Models::Product.new({
    code: '116600403',
    type: '0',
    quantity: 1
  })
  collect   = CorreiosSigep::Models::Collect.new({
    aditional_service: '10.00',
    ag: '5',
    ar: '1',
    card: '',
    checklist: '2',
    client_id: '102030',
    declared_value: '1000.00',
    description: 'Descricao',
    number: '',
    type: 'A'
  }.merge(sender: sender, objects: objects, product: product))

  logistic_reverse = CorreiosSigep::Models::LogisticReverse.new(recipient: recipient, collect: collect)
  collect_number = CorreiosSigep::LogisticReverse::RequestCollectNumber.new(logistic_reverse).process

```

## Contributing

1. Fork it ( https://github.com/duduribeiro/correios_sigep/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
