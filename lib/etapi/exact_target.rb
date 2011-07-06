require("etapi/calls/subscriber")
require("etapi/calls/tracking")

module ETAPI
  
  class Session
    
    # set default options
    DEFAULTS = {
      :api_method           => :xml,
      :use_s4               => false,
      :api_uri_xml          => "https://api.dc1.exacttarget.com/integrate.aspx",
      :api_uri_xml_s4       => "https://api.s4.exacttarget.com/integrate.aspx",
      :api_uri_soap         => "https://webservice.exacttarget.com/etframework.wsdl",
      :api_uri_soap_s4      => "https://webservice.s4.exacttarget.com/etframework.wsdl",
      :use_ssl              => true,
    }
    
    # allowed options
    ALLOWED_API_METHOD_OPTIONS  = [:xml, :soap]
    ALLOWED_USE_S4_OPTIONS      = [true, false]
    
    # initialize a new exact target instance
    def initialize(*args)
      
      # merge options with configuration
      options     = args.extract_options!
      @username   = options[:username]    ||= ETAPI.username
      @password   = options[:password]    ||= ETAPI.password
      @api_method = options[:api_method]  ||= ETAPI.api_method ||= DEFAULTS[:api_method]
      @use_s4     = options[:use_s4]      ||= ETAPI.use_s4     ||= DEFAULTS[:use_s4]
      @headers    = {"Content-Type" => "application/x-www-form-urlencoded", "Connection" => "close"}
      
      # check for required options
      raise ArgumentError, "* :api_method == :soap is currently not supported *" if @api_method.to_sym == :soap
      raise ArgumentError, "* missing :username *" if @username.blank?
      raise ArgumentError, "* missing :password *" if @password.blank?
      raise ArgumentError, "* invalid :api_method | options => [:xml, :soap] *" unless ALLOWED_API_METHOD_OPTIONS.include?(@api_method.to_sym)
      raise ArgumentError, "* invalid :use_s4 | options => [true, false] *" unless ALLOWED_USE_S4_OPTIONS.include?(@use_s4)
      
      # convert options
      @api_method = @api_method.to_sym
      
      # set uri
      if @api_method == :xml
        @api_uri = (@use_s4) ? DEFAULTS[:api_uri_xml_s4] : DEFAULTS[:api_uri_xml]
      else
        @api_uri = (@use_s4) ? DEFAULTS[:api_uri_soap_s4] : DEFAULTS[:api_uri_soap]
      end
      
      @api_wsdl = @api_uri if @use_s4
      
      # parse uri
      @api_uri   = URI.parse(@api_uri)
      @api_url   = Net::HTTP.new(@api_uri.host, @api_uri.port)
      
      # check for SSL (disabled)
      @api_url.use_ssl = options[:use_ssl] ||= DEFAULTS[:use_ssl]
      
    end
    
  end
  
end