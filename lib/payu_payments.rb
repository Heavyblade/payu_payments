require "payu_payments/version"

%w{ model caller client plan credit_card subscription recurring_bill_item }.each do |f|
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
        attr_accessor :api_key, :api_login, :merchant_id, :account, :mode, :show_log
        def initialize
            @show_log = false
        end
        def config
            {:api_key => @api_key,
             :api_login => @api_login,
             :merchant_id => @merchant_id,
             :account => @account,
             :show_log => @show_log,
             :mode => @mode}
        end
  end
end
