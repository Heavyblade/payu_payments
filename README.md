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

  client = Client.new(:fullName => "john Dow", :email => "johndoe@gmail.com")
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
  client.add_credit_card(creditCard)

```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/payu_payments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
