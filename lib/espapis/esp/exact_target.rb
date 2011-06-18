require("espapis/esp/exact_target/subscriber")

module ESP
  
  class ExactTarget
    
    include ESP::Render
    
    # set default options
    DEFAULTS = {
      :api_method           => :xml,
      :use_s4               => false,
      :api_uri_xml          => "https://api.dc1.exacttarget.com/integrate.aspx",
      :api_uri_xml_s4       => "https://api.s4.exacttarget.com/integrate.aspx",
      :api_uri_soap         => "https://webservice.exacttarget.com/etframework.wsdl",
      :api_uri_soap_s4      => "https://webservice.s4.exacttarget.com/etframework.wsdl",
      :use_ssl              => true,
      :header_content_type  => "application/x-www-form-urlencoded",
      :header_connection    => "close"
    }
    
    # allowed options
    ALLOWED_API_METHOD_OPTIONS  = [:xml, :soap]
    ALLOWED_USE_S4_OPTIONS      = [true, false]
    
    # initialize a new exact target instance
    def initialize(*args)
      
      # merge options with configuration
      options     = args.extract_options!
      @username   = options[:username]    ||= ESP.exact_target_username
      @password   = options[:password]    ||= ESP.exact_target_password
      @api_method = options[:api_method]  ||= ESP.exact_target_api_method ||= DEFAULTS[:api_method]
      @use_s4     = options[:use_s4]      ||= ESP.exact_target_use_s4     ||= DEFAULTS[:use_s4]
      
      # check for required options
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
      
      # parse uri
      @api_uri   = URI.parse(@api_uri)
      @api_url   = Net::HTTP.new(@api_uri.host, @api_uri.port)
      
      # check for SSL (disabled)
      @api_url.use_ssl = options[:use_ssl] ||= DEFAULTS[:use_ssl]
      
      # set headers
      @headers = {
        'Content-Type'  => DEFAULTS[:header_content_type],
        'Connection'    => DEFAULTS[:header_connection]
      }
      
    end
    
  end
  
end