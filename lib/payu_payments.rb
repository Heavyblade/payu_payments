require "payu_payments/version"

%w{ model caller client }.each do |f|
  require "payu_payments/#{f}"
end


module PayuPayments

  def self.config(&block)
    @configuration ||= Configuration.new
    unless block.nil?
      yield @configuration
    else
      @configuration.config
    end
  end

  class Configuration
    attr_accessor :api_key, :api_login, :merchant_id, :account, :mode
    def config
      {:api_key => @api_key, :api_login => @api_login, :merchant_id => @merchant_id, :account => @account, :mode => @mode}
    end
  end
end

PayuPayments.config do |config|
  config.api_key = "6u39nqhq8ftd0hlvnjfs66eh8c"
  config.api_login = "11959c415b33d0c"
  config.merchant_id = "500238"
  config.account = "5009"
  config.mode = "development"
end
