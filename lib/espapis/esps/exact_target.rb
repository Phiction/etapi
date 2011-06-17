module ESP
  
  class ExactTarget
    
    # Set Default Args
    DEFAULTS = {
      :api_uri => "https://www.exacttarget.com/api/integrate.asp?qf=xml",
      :use_ssl => true
    }
    
    # Initialize a New Exact Target Instance
    def initialize(*args)
      
      # set options
      options   = args.extract_options!
      username  = options[:username]
      password  = options[:password]
      api_uri   = options[:api_uri] ||= DEFAULTS[:api_uri]
      api_uri   = URI.parse(api_uri)
      api_url   = Net::HTTP.new(api_uri.host, api_uri.port)
      
      # check for SSL
      api_url.use_ssl = options[:use_ssl] ||= DEFAULTS[:use_ssl]
      
      # check for :username and :password
      raise ArgumentError, ":username must be passed on initialization." if username.blank?
      raise ArgumentError, ":password must be passed on initialization." if password.blank?
      
    end
    
    # 
    def status
      response = send do|io|
        io << render('ping')
      end
      Error.check_response_error(response)
      doc = Nokogiri::XML::Document.parse(response.read_body)
      @current_status = doc.xpath("//Ping").text
    end
    
    
  end
  
end