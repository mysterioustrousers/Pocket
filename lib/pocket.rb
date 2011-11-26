require "net/http"
require 'uri'

class Pocket
  
  def self.make_request(url, options = {})
    
    # defaults
    _options = {
      :method     => :get,
      :username   => nil,
      :password   => nil,
      :use_ssl    => false,
      :body       => nil,
      :headers    => {
        "Content-Type"  => "application/json",
        "Accept"        => "application/json",
      }
    }
    
    # merge passed in options with default options
    _options = _options.merge(options)
    
    # consolidate needed vars
    _url        = URI.parse(url)
    _method     = _options[:method]
    _username   = _options[:username]
    _password   = _options[:password]
    _use_ssl    = _options[:use_ssl]
    _body       = _options[:body]
    _headers    = _options[:headers]
    _path       = _url.path   ? _url.path         : ""
    _query      = _url.query  ? "?" + _url.query  : ""
    _api_query  = _path + _query
    
    # create http object
    http = Net::HTTP.new(_url.host, _url.port)
    http.use_ssl = _use_ssl
    
    # create request
    if _method == :get
      request = Net::HTTP::Get.new(_api_query, _headers)
    elsif _method == :post
      request = Net::HTTP::Post.new(_api_query, _headers)
      
      # add data
      request.set_form_data(_body)
      
    elsif _method == :put
      request = Net::HTTP::Put.new(_api_query, _headers)
      
      # add data
      request.set_form_data(_body)
      
    elsif _method == :delete
      request = Net::HTTP::Delete.new(_api_query, _headers)
      
      # add data
      request.set_form_data(_body)
      
    else
      request = Net::HTTP::Get.new(_api_query, _headers)
    end

    # add authentication (if present)
    if _username && _password
      request.basic_auth _username, _password
    end
    
    # make request
    response = http.request(request)
    
    # return response
    response
  end
end