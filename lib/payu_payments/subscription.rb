module PayuPayments

  class Subscription < Caller

    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    # Subscription attributes from Payu documentation
    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    #
    # id	36	String	Identificador de la suscripción en la plataforma PayU.
    # quantity	-	Integer	Cantidad de planes a adquirir con la suscripción.
    # installments	-	Integer	Número de cuotas en las que se diferirá cada cobro de la suscripción.
    # trialDays	-	Integer	Días de prueba que téndra la suscripción sin generar cobros.
    # customer	-	Customer	Cliente asociado a la suscripción. 
    # customer.credidcards	-	CreditCard	Tarjeta de crédito asociada al cliente. 
    # plan	-	Plan	Plan asociado a la suscripción.

    def initialize(params={})
      super
      @resource = "subscriptions"
    end

    def add_extra_charges(params={})
        url = "#{API_PATH}/#{self.attr.id}/recurringBillItems"
        http_call("put", url, params)
    end
  end

end
