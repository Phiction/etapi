module ESP
  
  class ExactTarget
    
    # set default options
    DEFAULTS = {
      :api_uri => "https://www.exacttarget.com/api/integrate.asp?qf=xml",
      :use_ssl => true,
      :header_content_type => "application/x-www-form-urlencoded",
      :header_connection => "close"
    }
    
    # initialize a new exact target instance
    def initialize(*args)
      
      # set options
      options   = args.extract_options!
      @username  = options[:username]
      @password  = options[:password]
      
      # check for :username and :password
      raise ArgumentError, ":username must be passed on initialization." if @username.blank?
      raise ArgumentError, ":password must be passed on initialization." if @password.blank?
      
      @api_uri   = options[:api_uri] ||= DEFAULTS[:api_uri]
      @api_uri   = URI.parse(@api_uri)
      @api_url   = Net::HTTP.new(@api_uri.host, @api_uri.port)
      
      # check for SSL
      @api_url.use_ssl = options[:use_ssl] ||= DEFAULTS[:use_ssl]
      
      @headers = {
        'Content-Type' => DEFAULTS[:header_content_type],
        'Connection' => DEFAULTS[:header_connection]
      }
      
    end
    
  end
  
end