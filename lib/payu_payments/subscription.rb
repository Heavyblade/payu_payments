module PayuPayments

  class Subscription < Caller
    def initialize(params={})
      super
      @resource = "plans"
    end
  end

end
