module PayuPayments

  class Client < Caller
    def initialize(params={})
      super
      @resource = "customers"
    end
  end

end