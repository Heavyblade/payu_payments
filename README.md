# PayuPayments

A Ruby wrapper for the [PayuLatam.com](http://www.payulatam.com/) payment gateway, it include the
managment of clients, plans, subscriptions and creditCards.

## Installation

Add this line to your application's Gemfile:

    gem 'payu_payments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payu_payments

## Usage

All the clases work as a simple CRUD objects, the models also have a
basic attributes validations.

## Configuration

To use the gem you need to set the keys available on your Payu account:


```ruby

  PayuPayments.config do |config|
    config.api_key = "xxxxxxxxxxxxxx"
    config.api_login = "xxxxxxx"
    config.merchant_id = "123456"
    config.account = "7890"
    config.mode = "development" # or production to point to production end-point
  end

```

In development mode all the calls will be hitting the test end-point
using the credentials that the API documentation [indicates](http://desarrolladores.payulatam.com/en/api-pruebas-pago/)


### Clients

To perform transactions with the API an entity representing the
custormer needs to be created, this entity is de Client and can be
created and updated using the PayuPayments::Client class.

```ruby
  @client = PayuPayments::Client.new(:fullName => "john Doe", :email => "johndoe@gmail.com")

  # or
  
  @client = PayuPayments::Client.new
  @client.fullName = "john Doe"
  @client.email = "johndoe@gmail.com"

  @client.save
```
You can also retrieve clients from the API if you know it's id

```ruby

  @client = PayuPayments::Client.find(123)
  @client.fullName = "New name"
  @client.save

```


### Credit Cards

You can store a tokenized credit card on the Payu tekenization
service by adding it to a client, in that way the credit card will be
stored directly in the PCI compliant gateway and can be used to charge the
client in future transactiosn without requiring to fill the credit card
form again.

```ruby
  @client = PayuPayments::Client.find(123)

  creditCard: {
      name: "Sample User Name",
      document: "1020304050",
      number: "4242424242424242",
      expMonth: "01",
      expYear: "2020",
      type: "VISA",
      address: {
                line1: "Address Name",
                line2: "17 25",
                line3: "Of 301",
                postalCode: "00000",
                city: "City Name",
                state: "State Name",
                country: "CO",
                phone: "300300300"
      }
  }

  credit_card = @client.add_credit_card(creditCard)

  ### To list the credit cards from a client
  
  @client.credit_cards
```

### Plans

To create a recurring payment model you need to create plans, plans
describe the different ways that you can sell your suscription based
products, here you describe the product how much you will charge for it an
how you want to charge for it

```ruby
  planParams = {
          plan: {
                planCode: "sample-plan-code-001",
                description: "Sample Plan 001",
                accountId: "1",
                intervalCount: "1",
                interval: "MONTH",
                maxPaymentsAllowed: "12",
                maxPaymentAttempts: "3",
                paymentAttemptsDelay: "1",
                maxPendingPayments: "0",
                trialDays: "30",
                additionalValues: {
                        additionalValue: [{ name: "PLAN_VALUE",
                                            value: "20000",
                                            currency: "COP"
                                          },
                                          {
                                            name: "PLAN_TAX",
                                            value: "1600",
                                            currency: "COP"
                                          }]
                }
          }
  }
  plan = PayuPayments::Plan.new(planParams)
  plan.save
  
  # or
  plan = PayuPayments::Plan.create(planParams)
```
### Subscriptions

Subscription will glue all together to create a subscription based
products, with a suscription you will bind a
client with a tokenized credit card with a plan,

```ruby
  PayuPayments::Subscription.create(subscription: {
                                        quantity: "1",
                                        installments: "1",
                                        trialDays: "15",
                                        customer: {
                                            id: @client.id,
                                            creditCards: {
                                                creditCard: { "token": credit_card.token }
                                        }
                                        },
                                        plan: { "planCode": plan.planCode }
                                    })

  # to check a client susbscriptions
  @client.subscriptions

```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/payu_payments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
