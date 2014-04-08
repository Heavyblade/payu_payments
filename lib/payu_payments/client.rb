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
      subs = []
      self.base.subscriptions.each do |sub|
          subscription =  Subscription.new
          subscription.base.marshal_load(sub)
          subs << subscription
      end
      subs
    end

    def credit_cards
      ccs = []
      self.base.creditCards.each do |sub|
          cc =  CreditCard.new
          cc.base.marshal_load(sub)
          ccs << cc
      end
      ccs
    end
  end

end
