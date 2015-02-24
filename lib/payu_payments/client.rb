module PayuPayments
  class Client < Caller

    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    # Client attributes from Payu documentation
    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    #
    # id
    # ullName
    # emai
    # creditCards
    # subscriptions

    def initialize(params={})
        super
        @resource = "customers"
    end

    def add_credit_card(params)
        cc = CreditCard.new(params)
        cc.attr.customerId = self.base.id
        cc.save
    end

    def subscriptions
        self.base.subscriptions.map do |sub|
            subscription =  Subscription.new
            subscription.base.marshal_load(sub)
            subscription
        end
    end

    def credit_cards
        self.base.creditCards.each.map do |sub|
            cc =  CreditCard.new
            cc.base.marshal_load(sub)
            cc
        end
    end
  end

end
