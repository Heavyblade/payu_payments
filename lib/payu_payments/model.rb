module Model
    def save 
      if new?  
        resp = post("/payments-api/rest/v4.3/#{@resource}", base.marshal_dump) 
      else 
        resp = put("/payments-api/rest/v4.3/#{@resource}/#{base.id}", :body => base.marshal_dump.to_json) 
      end 
      base.marshal_load resp
    end

    def create(params)
     post("/payments-api/rest/v4.3/#{@resource}", base.marshal_dump)
    end

    def edit(id)
      resp = get("/payments-api/rest/v4.3/#{@resource}/#{id}")
      base.marshal_load resp
    end

    def destroy(id)
      delete("/payments-api/rest/v4.3/#{@resource}/#{id}")
    end

    def new?
      base.id.nil?
    end

    def self.find(id)
      resp = get("/payments-api/rest/v4.3/#{@resource}/#{id}")
      self.new resp
    end
end
