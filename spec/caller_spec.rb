require 'spec_helper'

module PayuPayments

  describe Caller do
    
    it "Should set a base container to hold attributes" do
        call = Caller.new
        expect(call.base).to be_an_instance_of(OpenStruct)
    end

    it "should get access credentials from config" do
        ::PayuPayments.config do |config|
          config.api_key = "6u39nqhq8ftd0hlvnjfs66eh8c"
          config.api_login = "11959c415b33d0c"
          config.merchant_id = "500238"
          config.account = "5009"
          config.mode = "development"
        end

        call = Caller.new
        expect(call.access[:api_key]).to eq("6u39nqhq8ftd0hlvnjfs66eh8c")
        expect(call.access[:api_login]).to eq("11959c415b33d0c")
        expect(call.access[:merchant_id]).to eq("500238")
        expect(call.access[:account]).to eq("5009")
        expect(call.access[:mode]).to eq("development")
    end

    it "Should construct a base object with the initial params" do
        call = Caller.new(:name => "jhon", :last_name => "Doe", :number => 123)
        expect(call.base.name).to eq("jhon")
        expect(call.base.last_name).to eq("Doe")
        expect(call.base.number).to eq(123)
    end

    context "#get" do
      before(:each) do
        ::PayuPayments.config do |config|
          config.api_key = "6u39nqhq8ftd0hlvnjfs66eh8c"
          config.api_login = "11959c415b33d0c"
          config.merchant_id = "500238"
          config.account = "5009"
          config.mode = "development"
        end
      end

      it "should be able to peform a get request with the needed params" do
        attr = {:name => "jhon", :last_name => "Doe", :number => 123}
        call = Caller.new(attr)
        call.stub!(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Authorization' => "Basic abc123"}

        Caller.should_receive(:get).with("/someurl", :query => attr, :verify => false, :headers => headers)

        call.get("/someurl", attr)
      end

      it "Should provide the proper basic auth code" do
        attr = {:name => "jhon", :last_name => "Doe", :number => 123}
        code = Base64.encode64("11959c415b33d0c:6u39nqhq8ftd0hlvnjfs66eh8c")
        call = Caller.new(attr)
        headers = { 'Accept' => "application/json", 
                    'Authorization' => "Basic #{code}"}

        Caller.should_receive(:get).with("/someurl", :query => attr, :verify => false, :headers => headers)

        call.get("/someurl", attr)
      end
    end

    context "#post" do
      before(:each) do
        ::PayuPayments.config do |config|
          config.api_key = "6u39nqhq8ftd0hlvnjfs66eh8c"
          config.api_login = "11959c415b33d0c"
          config.merchant_id = "500238"
          config.account = "5009"
          config.mode = "development"
        end
      end

      it "should be able to peform a post request with the needed params" do
        attr = {:name => "jhon", :last_name => "Doe", :number => 123}
        call = Caller.new(attr)
        call.stub!(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Content-Type' => 'application/json; charset=UTF-8',
                    'Authorization' => "Basic abc123"}

        Caller.should_receive(:post).with("/someurl", :body => attr.to_json, :verify => false, :headers => headers)

        call.post("/someurl", attr)
      end

    end

  end


end
