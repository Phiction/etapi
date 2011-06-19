module ETAPI
  
  class Session
    
    def check_response(response)
      
      if @api_method == :soap
        
        response = Nokogiri::XML::Document.parse(response.http.body)
        response.remove_namespaces!
        
        error_code  = response.xpath("//ErrorCode")
        error_msg   = response.xpath("//StatusMessage")
        
        if error_code && error_msg && !error_code.empty? && !error_msg.empty?
          raise RuntimeError, "\n\n    Code:    #{error_code.text.to_i}\n    Message: #{error_msg.text}\n\n"
        end
        
      else
        raise Error.new(-1,'Network error') if response.class != Net::HTTPOK
      
        response = Nokogiri::XML::Document.parse(response.body)
      
        error_code  = response.xpath("//error")
        error_msg   = response.xpath("//error_description")
      
        if error_code && error_msg && !error_code.empty? && !error_msg.empty?
          raise RuntimeError, "\n\n    Code:    #{error_code.text.to_i}\n    Message: #{error_msg.text}\n\n"
        end
      end
      
    end
    
  end
  
end