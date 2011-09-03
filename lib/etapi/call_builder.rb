module ETAPI
  
  class Session
    
    def build_call(type, method, *args)
      
      options         = args.extract_options!
      ignore_parse  = options[:ignore_parse] || false
      
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
              if parameter[1].is_a?(Hash)
                xml.tag!(parameter[0]) do
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
      end
      
      data_encoded = "qf=xml&xml=" + url_encode(data)
      response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
      check_response(response)
      ignore_parse ? response.read_body : Nokogiri::XML::Document.parse(response.read_body)
      
    end
    
    private
    
    def print_xml(obj)
      require "rexml/document"
      doc = REXML::Document.new(obj.http.raw_body)
      out = ""
      doc.write(out, 1)
      out
    end
    
    def print_full_xml(obj)
      require "rexml/document"
      doc = REXML::Document.new(obj)
      out = ""
      doc.write(out, 1)
      out
    end
    
  end
  
end