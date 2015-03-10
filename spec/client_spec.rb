require 'spec_helper'

module PayuPayments

  describe Client do
     it "should be able to create a client" do
         client = Client.new(:fullName => "John Doe", :email => "johndoe@gmail.com")
         client.should_receive(:http_call).with("post", "/payments-api/rest/v4.3/customers", {:fullName => "John Doe", :email => "johndoe@gmail.com"}).and_return(:fullName => "John Doe", :email => "johndoe@gmail.com")
         client.save
     end

     it "should validate the required fields" do
         client = Client.new
         client.should_not be_valid
         expect(client.errors.count).to be > 0
         expect(client.errors[0][:field]).to eql(:fullName)
         expect(client.errors[1][:field]).to eql(:email)
     end

     it "should validate the format of the email" do
         client = Client.new(:fullName => "John Doe", :email => "johndoegmail.com")
         client.should_not be_valid
         expect(client.errors[0][:field]).to eql(:email)
         expect(client.errors[0][:message]).to eql("The Email doesn't have the correct format")
     end 

     it "should be able to find a client with its id" do
         call = Client.new
         call.should_receive(:http_call).with("get","/payments-api/rest/v4.3/customers/1").and_return(:fullName => "John Doe", :email => "johndoe@gmail.com", :id => 1)
         Client.should_receive(:new).twice.and_return(call)
         client = Client.find(1) 
         expect(client).to be_an_instance_of(Client)
     end

     it "should save a credit card related to the client" do
       client = Client.new(:id => "123", :fullName => "John Doe", :email => "johndoe@gmail.com")
       cc = CreditCard.new
       CreditCard.should_receive(:new).and_return(cc)
       cc.stub(:save => true)
       client.add_credit_card({number: "1234", :name => "John Doe"})
     end

     it "should be able to load credit cards" do
       response = {
                  id: "2mkls9xekm",
                  fullName: "Pedro Perez",
                  email: "pperez@payulatam.com",
                  creditCards: [
                                  {
                                  token: "da2224a9-58b7-482a-9866-199de911c23f",
                                  customerId: "2mkls9xekm",
                                  number: "************4242",
                                  name: "Usuario Prueba",
                                  type: "VISA",
                                  address: {
                                              line1: "Street 93B",
                                              line2: "17 25",
                                              line3: "Office 301",
                                              city: "Bogota",
                                              country: "CO",
                                              postalCode: "00000",
                                              phone: "300300300"
                                              }
                                  }
                  ]
                  }
        Client.should_receive(:find).and_return(Client.new(response))
        client = Client.find("2mkls9xekm")
        expect(client.base.id).to eq("2mkls9xekm")
        expect(client.credit_cards[0].attr.number).to eql("************4242")
     end

     it "should be able to load subscriptions" do
       response = {
                  id: "2mkls9xekm",
                  fullName: "Pedro Perez",
                  email: "pperez@payulatam.com",
                  subscriptions: [
                                    {
                                    id: "2mlhk3qxji",
                                    quantity: "1",
                                    installments: "1",
                                    currentPeriodStart: "2013-08-30T10:46:41.477-05:00",
                                    currentPeriodEnd: "2013-09-29T10:46:41.477-05:00",
                                    plan: {
                                              id: "414215a2-c990-4525-ba84-072181988d09",
                                              planCode: "PLAN-REST-16",
                                              description: "Plan rest test",
                                              accountId: "1",
                                              intervalCount: "1",
                                              interval: "MONTH",
                                              additionalValues: [
                                                                  {
                                                                  name: "PLAN_VALUE",
                                                                  value: "20000",
                                                                  currency: "COP"
                                                                  }]
                                            }
                                      }
                  ]
                  }
        Client.should_receive(:find).and_return(Client.new(response))
        client = Client.find("2mkls9xekm")
        expect(client.base.id).to eq("2mkls9xekm")
        expect(client.subscriptions[0].attr.id).to eql("2mlhk3qxji")
     end
  end
end
