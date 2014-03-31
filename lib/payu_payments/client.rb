module PayuPayments

  class Client < Caller

    def save
      if new?
        resp = post("/payments-api/rest/v4.3/customers", base.marshal_dump)
      else
        resp = put("/payments-api/rest/v4.3/customers", :body => base.marshal_dump.to_json)
      end
      base.marshal_load resp
    end

    def create(params)
      post("/payments-api/rest/v4.3/customers", base.marshal_dump)
    end

    def edit(id)
      resp = get("/payments-api/rest/v4.3/customers/#{id}")
      base.marshal_load resp
    end

    def destroy(id)
      resp = delete("/payments-api/rest/v4.3/customers/#{id}")
    end

    def new?
      base.id.nil?
    end

    def self.find(id)
      resp = get("/payments-api/rest/v4.3/customers/#{id}")
      self.new resp
    end
  end

end
