require 'httparty'
require "base64"
require 'ostruct'

module PayuPayments
  class Caller
    include ::HTTParty
    API = "https://api.payulatam.com"
    API_SANDBOX = "https://stg.api.payulatam.com"

    attr_accessor :access, :base
    format :json
    debug_output $stdout

    def set_base_uri
      if PayuPayments.config[:mode] == "production"
        self.class.base_uri API
      else
        self.class.base_uri API_SANDBOX
      end
    end

    def initialize(params={})
      self.set_base_uri
      @access = PayuPayments.config
      @base = OpenStruct.new
      base.marshal_load params
    end
 
    def ping(params)
        get("/", :command => "PING")
    end


    def get(url, params={})
        headers = { 'Accept' => "application/json", 
                    'Authorization' => "Basic #{basic_auth.to_s}"}
        self.class.get(url, :query => params, :verify => false, :headers => headers)
    end

    def post(url, params)
        headers = { 'Accept' => "application/json", 
                    'Content-Type' => 'application/json; charset=UTF-8',
                    'Authorization' => "Basic #{basic_auth.to_s}"}
        self.class.post(url, :body => params.to_json, :verify => false, :headers => headers)
    end


private

    def basic_params
        { :language => "ES", 
          :test => (access[:mode] == "development"),
          :merchant => { :apiLogin => access[:api_login], 
                         :apiKey => access[:api_key]
                        }
        }
    end

    def basic_auth
        Base64.encode64("#{access[:api_login]}:#{access[:api_key]}")
    end

  end
end
