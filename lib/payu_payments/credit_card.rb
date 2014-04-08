module PayuPayments

  class CreditCard < Caller

    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    # Credit Card attributes from Payu documentation
    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    #
    # Token	Longitud = [0,36]	String	Token asociado a una tarjeta de crédito.
    # customerId	Longitud = #[0,64]	String	Código de identificación del cliente al cual pertenece la tarjeta de crédito
    # Number	Longitud = [13,20] # Patrón = [0-9]*{13,20}	String	Número de la tarjeta de crédito
    # expMonth	Min = 1,#Máx = 12	Integer	Mes de expiración de la tarjeta de crédito.
    # expYear	Min= 0, 
    # Max = 2999	Integer	Año de expiración de la tarjeta de crédito.
    #             Si el valor es de dos dígitos corresponde al año comprendido entre 2000 (00) y 2099 (99).
    #             Si el valor es de más de dos dígitos se toma literal, siendo el año 2000 como mínimo posible.
    # Type		Enumeration	Corresponde a la franquicia o tipo de tarjeta de crédito. Los posibles valores son:
    #         VISA, AMEX, DINERS, MASTERCARD, ELO, SHOPPING, NARANJA, CABAL y ARGENCARD.
    # Name	255	String	Nombre del tarjeta habiente.
    # document	Longitud = #[5, 30]	String	Número del documento de identificad del tarjeta habiente.
    # address	-	Address	Dirección de correspondencia del tarjeta habiente asociado con la tarjeta de crédito.
    # issuerBank	255	String	Nombre del banco emisor de la tarjeta de crédito.
    #
    # City	      Longitud = [0, 50]	String	Nombre de la ciudad.
    # country	    Longitud = [2, 2]	String	Código ISO 3166 (2 letras – Alpha 2) del país de la dirección.
                             #Ver países soportados
    # linea1	    Longitud = [0, 100]	String	Primera línea de la dirección.
    # linea2	    Longitud = [0, 100]	String	Segunda línea de la dirección o número de la dirección.
    # linea3	    Longitud = [0, 100]	String	Tercera línea de la dirección o complemento de la dirección.
    # phone	      Longitud = [0, 20]	String	Teléfono asociado a la dirección.
    # postalCode	Longitud = [0, 20]	String	Código postal de la dirección.
    # State	      Longitud = [0, 40]	String	Nombre del estado de la dirección.

    def initialize(params={})
      super
      @resource = "creditCards"
    end

    def save 
      @url = new? ? "#{API_PATH}/customers/#{attr.customerId}/#{@resource}" : "#{API_PATH}/#{@resource}/#{base.id}"
      super
    end

    def self.create(customer_id, params)
      url = "#{API_PATH}/customers/#{attr.customerId}/#{@resource}"
      self.base.marshal_load params
      resp = http_call("post", url, attr.marshal_dump) 
      base.marshal_load resp
    end

    def destroy(customer_id, id)
      customer_id = self.attr.customerId
      id = self.attr.id
      @url = "#{API_PATH}/customers/#{customer_id}/#{@resource}/#{id}}"
      super
    end
  end

end
