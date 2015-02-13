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

    context "validations" do

      it "should be able to validate the lenght of a fiekd" do
        call = Caller.new(:name => "jhon")
        call.validate_lenght_of(:name, 5)
        expect(call.errors.count).to eq(1)
        expect(call.errors.first[:message]).to eq("lenght of name should be 5")
      end

    end



    context "performing http calls" do
      let (:resp) {a = {"valor1" => "hola"}; a.stub(:code => "200"); a}
      before :each do
        ::PayuPayments.config do |config|
          config.api_key = "6u39nqhq8ftd0hlvnjfs66eh8c"
          config.api_login = "11959c415b33d0c"
          config.merchant_id = "500238"
          config.account = "5009"
          config.mode = "development"
        end
      end

      it "should be able to perform POST calls" do
        attr = {fullName: "john doe", email: "jhon@doe.com"}
        call = Caller.new(attr)
        call.stub(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Content-Type' => 'application/json; charset=UTF-8',
                    'Authorization' => "Basic abc123"}
        Caller.should_receive(:send).with("post", "/someurl", :body => attr.to_json, :verify => false, :headers => headers).and_return(resp)
        call.http_call("post", "/someurl", attr)
      end

      it "should be able to perform PUT calls" do
        attr = {fullName: "john doe", email: "jhon@doe.com"}
        call = Caller.new(attr)
        call.stub(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Content-Type' => 'application/json; charset=UTF-8',
                    'Authorization' => "Basic abc123"}
        Caller.should_receive(:send).with("put", "/someurl", :body => attr.to_json, :verify => false, :headers => headers).and_return(resp)
        call.http_call("put", "/someurl", attr)
      end


      it "should be able to perform GET calls" do
        attr = {fullName: "john doe", email: "jhon@doe.com"}
        call = Caller.new(attr)
        call.stub(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Authorization' => "Basic abc123"}
        Caller.should_receive(:send).with("get", "/someurl", :query => attr, :verify => false, :headers => headers).and_return(resp)
        call.http_call("get", "/someurl", attr)
      end

      it "should be able to perform DELETE calls" do
        attr = {fullName: "john doe", email: "jhon@doe.com"}
        call = Caller.new(attr)
        call.stub(:basic_auth => "abc123")
        headers = { 'Accept' => "application/json", 
                    'Authorization' => "Basic abc123"}
        Caller.should_receive(:send).with("delete", "/someurl", :query => attr, :verify => false, :headers => headers).and_return(resp)
        call.http_call("delete", "/someurl", attr)
      end
    end

  end


end
