module PayuPayments

  class RecurringBillItem < Caller
    def initialize(params={})
      super
      @resource = "recurringBillItems"
    end

    def save 
      if new?  
        resp = post("/rest/v4.3/subscriptions/#{base.subscription_id}/#{@resource}", base.marshal_dump)
      else 
        resp = put("/rest/v4.3/#{@resource}/#{base.id}", :body => base.marshal_dump.to_json)
      end 
      base.marshal_load resp
    end

    def create(params)
     post("/rest/v4.3/subscriptions/#{base.subscription_id}/#{@resource}", base.marshal_dump)
    end

    def destroy
      delete("/rest/v4.3/#{@resource}/#{base.id}")
    end
  end

end
