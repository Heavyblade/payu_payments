module PayuPayments

  class RecurringBillItem < Caller
    def initialize(params={})
      super
      @resource = "recurringBillItems"
    end

    def save 
      verb = new? ? "post" : "put"
      url = new? ? "#{API_PATH}/subscriptions/#{base.subscription_id}/#{@resource}" : "#{API_PATH}/#{@resource}/#{base.id}"
      resp = http_call(verb, url, base.marshal_dump) 
      base.marshal_load resp
    end

    def create(params)
      url = "#{API_PATH}/subscriptions/#{attr.subscription_id}/#{@resource}"
      resp = http_call(verb, url, base.marshal_dump) 
      base.marshal_load resp
    end

    def get_recurring_bill_items
      url = "#{API_PATH}/#{@resource}/params"
      resp = http_call(verb, url, base.marshal_dump) 
      base.marshal_load resp
    end

  end

end
