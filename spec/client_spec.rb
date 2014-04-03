require 'spec_helper'

module PayuPayments

  describe Client do
     it "should be able to create a client" do
       client = Client.new(:fullName => "John Doe", :email => "johndoe@gmail.com")
       client.should_receive(:http_call).with("post", "/payments-api/rest/v4.3/customers", {:fullName => "John Doe", :email => "johndoe@gmail.com"}).and_return(:fullName => "John Doe", :email => "johndoe@gmail.com")
       client.save
     end

     it "should be able to find a client with its id" do
        call = Client.new
        call.should_receive(:http_call).with("get","/payments-api/rest/v4.3/customers/1").and_return(:fullName => "John Doe", :email => "johndoe@gmail.com", :id => 1)
        Client.should_receive(:new).twice.and_return(call)
        client = Client.find(1) 
        expect(client).to be_an_instance_of(Client)
     end
  end
end
