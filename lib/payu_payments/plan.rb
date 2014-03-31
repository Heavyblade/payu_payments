module PayuPayments

  class Plan < Caller
    def initialize(params={})
      super
      @resource = "plans"
    end
  end

end
