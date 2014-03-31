require 'spec_helper'
describe PayuPayments  do

  context "Configuration" do
    it "should be able to set configuration keys" do
        PayuPayments.config do |config|
          config.api_key = "xxx"
          config.merchant_id = "123"
          config.account = "abc123"
        end
    end

    it "should be able to read configuration keys" do
        PayuPayments.config[:api_key].should == "xxx"
    end
  end
end
