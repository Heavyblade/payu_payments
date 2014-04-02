require 'spec_helper'

module PayuPayments

  describe Client do
     it "should be able to create a client" do
       client = Client.new(:fullName => "John Doe", :email => "johndoe@gmail.com")
       client.should_receive(:post).with("/payments-api/rest/v4.3/customers", {:fullName => "John Doe", :email => "johndoe@gmail.com"}).and_return(:fullName => "John Doe", :email => "johndoe@gmail.com")
       client.save
     end
  end
end
