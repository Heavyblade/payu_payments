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

    def validate
        self.errors = []
        [:fullName, :email].each do |field|
          validate_presence_of(field)
        end

        validates_format_of :email, /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, "The Email doesn't have the correct format"
    end

  end
end
