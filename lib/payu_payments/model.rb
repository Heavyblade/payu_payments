module Model
    API_PATH = "/payments-api/rest/v4.3"

    def self.included(base)
        base.send :extend, ClassMethods
    end

    def save 
        if new?  
          resp = http_call("post", "#{API_PATH}/#{@resource}", base.marshal_dump) 
        else 
          resp = http_call("put", "#{API_PATH}/#{@resource}/#{base.id}", base.marshal_dump) 
        end 
        base.marshal_load resp
    end

    def create(params)
        http_call("post", "#{API_PATH}/#{@resource}", base.marshal_dump)
    end

    def edit(id)
        resp = http_call("get", "#{API_PATH}/#{@resource}/#{id}")
        base.marshal_load resp
    end

    def destroy(id)
        http_call("delete", "#{API_PATH}/#{@resource}/#{id}")
    end

    def new?
        base.id.nil?
    end

    # Class Methods
    module ClassMethods
        def find(id)
            resp = self.new
            json = resp.http_call("get", "#{API_PATH}/#{resp.resource}/#{id}")
            self.new json
        end
    end
end
