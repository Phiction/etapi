require("erb")
include ERB::Util

module ESP
  
  class ExactTarget
    
    # Set Default Args
    DEFAULTS = {
      :api_uri => "https://www.exacttarget.com/api/integrate.asp?qf=xml",
      :use_ssl => true,
      :header_content_type => "application/x-www-form-urlencoded",
      :header_connection => "close"
    }
    
    # Initialize a New Exact Target Instance
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
    
    def status
      response = send do |io|
        io << render('status')
      end
      Error.check_response_error(response)
      doc = Nokogiri::XML::Document.parse(response.read_body)
      @current_status = doc.xpath("//Ping").text
    end
    
    def send
      @system = ""
      yield @system

      data = ""
      xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
      xml.instruct!

      xml.exacttarget do |x|
        x.authorization do
          x.username @username
          x.password @password
        end
        x << @system
      end
      
      
      
      @debug = data

      data_encoded = url_encode(data)

      result = 'qf=xml&xml=' + data_encoded
      
      ESP.log(result)
      
      @api_url.post( @api_uri.path, result, @headers.merge('Content-length' => result.length.to_s) )
    end
    
   private
    
    def path(name)
      File.join(File.dirname(__FILE__), "exact_target/templates/#{name}.rxml")
    end
    
    def render(template)
      ESP.log("In PRIVATE RENDER")
      erb = ERB.new( File.open( path(template) ,"r").read, 0, "<>" )
      erb.result( binding )
    end
    
    
    
  end
  
end