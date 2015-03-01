require 'httparty'
require "base64"
require 'ostruct'

module PayuPayments
  class Caller
    include ::HTTParty
    include Model
 
    API = "https://api.payulatam.com"
    API_SANDBOX = "https://stg.api.payulatam.com"

    attr_accessor :access, :base, :resource, :errors
    format :json
    alias :attr :base

    def set_base_uri
        self.class.base_uri(PayuPayments.config[:mode] == "production" ? API : API_SANDBOX)
    end

    def initialize(params={})
        @access = PayuPayments.config
        self.set_base_uri
        self.class.debug_output $stdout if @access[:show_log]

        @base = OpenStruct.new
        base.marshal_load params
        @errors = []
    end
 
    def http_call(type, url, params={})
        if ["post", "put"].include? type
            headers = { 'Accept' => "application/json", 
                        'Content-Type' => 'application/json; charset=UTF-8',
                        'Authorization' => "Basic #{basic_auth}"}
            resp = self.class.send(type, url, :body => params.to_json, :verify => (access[:mode] == "production"), :headers => headers)
        else
            headers = { 'Accept' => "application/json", 
                        'Authorization' => "Basic #{basic_auth}"}
            resp = self.class.send(type, url, :query => params, :verify => (access[:mode] == "production"), :headers => headers)
        end

        respond_with = (resp == "" or resp.nil?) ? {} : resp.inject({ }) { |h, (k,v)| h[k.to_sym] = v; h }

        if resp.code.to_s.match(/2\d\d/)
           respond_with
        else
           {"type" => respond_with[:type], "description" => respond_with[:description]}
        end
    end


private

    def basic_auth
        Base64.encode64("#{access[:api_login]}:#{access[:api_key]}")
    end

  end
end
