module PayuPayments

  class CreditCard < Caller
    def initialize(params={})
      super
      @resource = "creditCards"
    end

    def save 
      if new?  
        resp = post("/rest/v4.3/customers/#{customer_id}/#{@resource}", base.marshal_dump) 
      else 
        resp = put("/rest/v4.3/#{@resource}/#{base.id}", :body => base.marshal_dump.to_json) 
      end 
      base.marshal_load resp
    end

    def create(customer_id, params)
     post("/rest/v4.3/customers/#{customer_id}/#{@resource}", base.marshal_dump)
    end

    def destroy(customer_id, id)
      delete("/rest/v4.3/customers/#{customer_id}/#{@resource}/#{id}")
    end
  end

end
