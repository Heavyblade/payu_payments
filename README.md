# PayuPayments

A wrapp for the PayuLata.com payment gateway

## Installation

Add this line to your application's Gemfile:

    gem 'payu_payments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payu_payments

## Usage

```ruby

  client = PayuPayments::Client.new(:fullName => "john Dow", :email => "johndoe@gmail.com")
  creditCard: {
      name: "Sample User Name",
      document: "1020304050",
      number: "4242424242424242",
      expMonth: "01",
      expYear: "2018",
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

  credit_card = client.add_credit_card(creditCard)
  plan = {
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
  plan = Plan.new(plan)

  PayuPayments::Subscription.create(subscription: {
                                        quantity: "1",
                                        installments: "1",
                                        trialDays: "15",
                                        customer: {
                                            id: client.id,
                                            creditCards: {
                                                creditCard: { "token": credit_card.token }
                                        }
                                        },
                                        plan: { "planCode": plan.planCode }
                                    })

```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/payu_payments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
