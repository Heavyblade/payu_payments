module PayuPayments
  class Plan < Caller

    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    # Plan attributes from Payu documentation
    # xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    #
    # id                        36	String  Identificador del plan en la plataforma de PayU.
    # planCode                  255	String  Código único que el comercio le asigna al plan para su posterior identificación. Este código de plan no se puede volver a repetir aun cuando el plan sea borrado.
    # description               255	String  Descripción del plan.
    # accountId                     Integer Identificador de la cuenta del comercio al cual se asocia el plan.
    # interval                  5   String  Intervalo que define cada cuanto se realiza el cobro de la suscripción. Los valores posibles son:
    #                                        DAY, WEEK, MONTH y YEAR.
    # intervalCount                 Integer Cantidad del intervalo que define cada cuanto se realiza el cobro de la suscripción.
    # additionalValue.currency  3   String  Código ISO 4217 de la moneda del valor asociado al plan.
    # additionalValue.name      255 String  Nombre del campo del valor asociado al plan. Los valores posibles son:
    #                                       PLAN_VALUE: valor total de plan. 
    #                                       PLAN_TAX_VALUE: valor de los impuestos asociados al valor del plan. 
    #                                       PLAN_TAX_RETURN_BASE: valor base para el retorno de impuestos asociados al plan.
    # additionalValue.value         Decimal Valor del plan, impuesto o base de retorno de acuerdo a plan.additionalValue.name.
    # trialDays                     Integer Cantidad de días de prueba de la suscripción.
    # maxPaymentAttempts        Máx. 3      Integer	Cantidad total de reintentos para cada pago rechazado de la suscripción.
    # maxPaymentsAllowed            Integer Cantidad total de pagos de la suscripción.
    # maxPendingPayments            Integer Cantidad máxima de pagos pendientes que puede tener una suscripción antes de ser cancelada.
    # paymentAttemptsDelay

    def initialize(params={})
        super
        @resource = "plans"
    end

    def save
        verb = new? ? "post" : "put"
        url = new? ? "#{API_PATH}/#{@resource}" : "#{API_PATH}/#{@resource}/#{base.planCode}"
        not_allowed_for_update = [:maxPaymentsAllowed, :trialDays, :id, :intervalCount, :interval, :accountId]

        params = base.marshal_dump
        not_allowed_for_update.each {|x| params.delete(x) } unless new?
        resp = http_call(verb, url, params)

        base.marshal_load resp
    end

    def self.create_base_month_plan(name, value, custom_options={})
        params = {
            planCode: name,
            description: "#{name} plan",
            accountId: PayuPayments.config[:account],
            intervalCount: 1,
            interval: "MONTH",
            maxPaymentsAllowed: 2000,
            maxPaymentAttempts: 3,
            paymentAttemptsDelay: 5,
            maxPendingPayments: 0,
            trialDays: 0,
            additionalValues: [{
                                name: "PLAN_VALUE",
                                value: value,
                                currency: "COP"
                                }]
        }
        params.merge!(custom_options)
        self.new params
    end


    def destroy
        http_call("delete", "#{API_PATH}/#{@resource}/#{self.attr.planCode}")
    end
  end
end
