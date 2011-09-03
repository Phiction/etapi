module ETAPI
  
  class Session
    
    def check_response(response)
      
      raise Error.new(-1, 'Network error') if response.class != Net::HTTPOK
      
      response = Nokogiri::XML::Document.parse(response.body)
      
      error_code  = response.xpath("//error")
      error_msg   = response.xpath("//error_description")
      
      if !error_code.blank? && !error_msg.blank?
        if ETAPI.raise_errors?
          raise(RuntimeError, "\n\n    Code:    #{error_code.text.to_i}\n    Message: #{error_msg.text}\n\n")
        else
          ETAPI.log("    Code:    #{error_code.text.to_i}\n    Message: #{error_msg.text}") if ETAPI.log?
          return false
        end
      end
      
    end
    
    def check_required(required_options)
      missing_options = []
      
      for option in required_options
        missing_options << ":#{option}" if eval("@#{option}.blank?")
      end
      
      if !missing_options.blank?
        if ETAPI.log?
          ETAPI.log("    Code:    ETAPI\n    Message: missing #{missing_options.join(', ')}")
        elsif ETAPI.raise_errors?
          raise(ArgumentError, "\n\n    Code:    ETAPI\n    Message: missing #{missing_options.join(', ')}\n\n")
        end
        return false
      end
      
      return true
    end
    
  end
  
end