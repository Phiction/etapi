module ESP
  
  class ExactTarget
    
    DEFAULT = {
      :api_uri => "https://www.exacttarget.com/api/integrate.asp?qf=xml",
      :use_ssl => true
    }
    
    def initialize(*args)
      
      # set options
      options   = args.extract_options!
      username  = options[:username]
      password  = options[:password]
      api_uri   = options[:api_uri] ||= DEFAULT[:api_uri]
      api_uri   = URI.parse(api_uri)
      api_url   = Net::HTTP.new(api_uri.host, api_uri.port)
      
      # check for SSL
      api_url.use_ssl = options[:use_ssl] ||= DEFAULT[:use_ssl]
      
      ESP.log(api_url.inspect)
      
      # check for :username and :password
      raise ArgumentError, ":username must be passed on initialization." if username.blank?
      raise ArgumentError, ":password must be passed on initialization." if password.blank?
      
    end
    
  end
  
end