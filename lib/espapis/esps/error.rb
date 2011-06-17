module ESP
  class Error < RuntimeError
    attr_reader :code, :message
    def initialize(error_code,error_msg)
      @code = error_code
      @message = error_msg
    end

    def to_s
      "Code: #{@code}.  Message: #{@message}"
    end

    # raise a new error object from an HTTP response if it contains an error
    def self.check_response_error(response)
      if response.class != Net::HTTPOK
        raise Error.new(-1,'Network error')
      end
      doc = Nokogiri::XML::Document.parse(response.body)

      error_code = doc.xpath("//error")
      error_msg = doc.xpath("//error_description")
      if( error_code and error_msg and !error_code.empty? and !error_msg.empty? )
        raise Error.new(error_code.text.to_i,error_msg.text)
      end
    end
  end
end