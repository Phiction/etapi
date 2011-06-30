module ETAPI
  
  class Session
    
    def build_call(type, method)
      
      if @api_method == :xml
        
        data = ""
        xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
        xml.instruct!
        xml.exacttarget do
          xml.authorization do
            xml.username @username
            xml.password @password
          end
          xml.system do
            xml.system_name type
            xml.action method
            for parameter in @parameters
              if parameter[0] == "values"
                xml.values do
                  parameter[1].each do |key, value|
                    eval("xml.#{key.gsub(/\s/, '__')} '#{value}'")
                  end
                end
              else
                eval("xml.#{parameter[0]} '#{parameter[1]}'")
              end
            end
          end
        end
        
        data_encoded = "qf=xml&xml=" + url_encode(data)
        response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
        check_response(response)
        response = Nokogiri::XML::Document.parse(response.read_body)
        
        subscriber_id     = response.xpath("//subscriber_description").text.to_i
        subscriber_msg    = response.xpath("//subscriber_info").text
        
        if !subscriber_id.blank? && !subscriber_msg.blank?
          ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}") if ETAPI.log?
          return subscriber_id
        else
          return false
        end
        
      elsif type == :soap
        if true # wrap
        #     session = Savon::Client.new(@api_wsdl)
        #     session.wsse.username = @username
        #     session.wsse.password = @password
        #     
        #     @attributes = @attributes.map{|name, value| {"wsdl:Name" => "#{name}", "wsdl:Value" => "#{(value.is_a?(Array)) ? value.join(',') : value}"} }
        #   
        #     soap_input = 'wsdl:CreateRequest'
        #     if !@list_id.blank?
        #       soap_body = {
        #         'wsdl:Objects' => {
        #           'wsdl:EmailAddress' => @email,
        #           'wsdl:Attributes' => @attributes,
        #           'wsdl:Lists' => {
        #             'wsdl:ID' => @list_id,
        #             'wsdl:Status' => 'Active'
        #           },
        #           :attributes! => {
        #             'wsdl:Lists' => {'xsi:type' => 'wsdl:SubscriberList'}
        #           }
        #         
        #         },
        #         :attributes! => {
        #           'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
        #         }
        #       }
        #     else
        #       soap_body = {
        #         'wsdl:Objects' => {
        #           'wsdl:EmailAddress' => @email,
        #           'wsdl:Attributes' => @attributes
        #         },
        #         :attributes! => {
        #           'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
        #         }
        #       }
        #     end
        #   
        #     response = session.request(:create) do |soap|
        #       soap.input = soap_input
        #       soap.body  = soap_body
        #     end
        #   
        #     response = Nokogiri::XML(response.http.body).remove_namespaces!
        #   
        #     check_response(response)
        #   
        #     subscriber_id     = response.xpath("//NewID").text.to_i
        #     subscriber_msg    = response.xpath("//StatusMessage").text
        #     
        #     ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}")
        #   
        #     return subscriber_id
        end
      end
      
    end
    
  end
  
end