module ETAPI
  
  class Session
    
    def subscriber_add(*args)
      #a.subscriber_add(:email => 'test@test.com', :attributes => {'Full Name' => 'Demo User'})
      #a.subscriber_add(:email => 'test@test.com', :attributes => {'Full Name' => 'Demo User'}, :list_id => 111247)
      #a.subscriber_add(:email => 'test@test.com', :account_id => 1044867, :attributes => {'Full Name' => 'Demo User'})
      #a.subscriber_add(:email => 'test@test.com', :account_id => 1044867, :attributes => {'Full Name' => 'Demo User'}, :list_id => 111247)
      
      # options
      options         = args.extract_options!
      @list_id        = options[:list_id] ||= nil
      @email          = options[:email]
      @full_name      = options[:full_name]
      @attributes     = options[:attributes] ||= []
      @account_id     = options[:account_id]
      
      # check for required options
      raise ArgumentError, "* missing :email *" if @email.blank?
      raise ArgumentError, "* missing :list_id | must include :list_id if the api_method is :xml * " if @list_id.blank? && @api_method == :xml
      
      # convert options
      @list_id = @list_id.to_i unless @list_id.blank?
      
      if @api_method == :soap
        if true # wrap
          session = Savon::Client.new(@api_wsdl)
          session.wsse.username = @username
          session.wsse.password = @password

          @attributes = @attributes.map{|name, value| {"wsdl:Name" => "#{name}", "wsdl:Value" => "#{(value.is_a?(Array)) ? value.join(',') : value}"} }
        
          soap_input = 'wsdl:CreateRequest'
          if !@list_id.blank?
            soap_body = {
              'wsdl:Objects' => {
                'wsdl:EmailAddress' => @email,
                'wsdl:Attributes' => @attributes,
                'wsdl:Lists' => {
                  'wsdl:ID' => @list_id,
                  'wsdl:Status' => 'Active'
                },
                :attributes! => {
                  'wsdl:Lists' => {'xsi:type' => 'wsdl:SubscriberList'}
                }
              
              },
              :attributes! => {
                'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
              }
            }
          else
            soap_body = {
              'wsdl:Objects' => {
                'wsdl:EmailAddress' => @email,
                'wsdl:Attributes' => @attributes
              },
              :attributes! => {
                'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
              }
            }
          end
        
          response = session.request(:create) do |soap|
            soap.input = soap_input
            soap.body  = soap_body
          end
        
          response = Nokogiri::XML(response.http.body).remove_namespaces!
        
          check_response(response)
        
          subscriber_id     = response.xpath("//NewID").text.to_i
          subscriber_msg    = response.xpath("//StatusMessage").text
    
          ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}")
        
          return subscriber_id
        end
      else
        if true # wrap
          # build xml data
          data = ""
          xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
          xml.instruct!
          xml.exacttarget do
            xml.authorization do
              xml.username @username
              xml.password @password
            end
            xml.system do
              xml.system_name "subscriber"
              xml.action "add"
              xml.search_type @list_id.blank? ? nil : "listid"
              xml.search_value @list_id.blank? ? nil : @list_id
              xml.search_value2 nil
              xml.values do
                xml.Email__Address @email
                xml.status "active"
                @attributes.each do |name, value|
                  eval("xml.#{name.gsub(' ', '__')} '#{(value.is_a?(Array)) ? value.join(',') : value}'")
                end
              end
              xml.update true
            end
          end
      
          data_encoded = "qf=xml&xml=" + url_encode(data)
      
          response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
          check_response(response)
          response = Nokogiri::XML::Document.parse(response.read_body)
      
          subscriber_id     = response.xpath("//subscriber_description").text.to_i
          subscriber_msg    = response.xpath("//subscriber_info").text
      
          ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}")
          
          return subscriber_id
        end
      end
      
    end
    
    def subscriber_edit(*args)
      #a.subscriber_edit(:list_id => 111247, :email => 'test@test.com')
      #a.subscriber_edit(:subscriber_id => 241224046, :attributes => {'Email Address' => 'test1@test.com', 'First Name' => 'Chris'})
      #a.subscriber_edit(:subscriber_id => 241224046, :account_id => 1044867, :attributes => {'Email Address' => 'test1@test.com', 'First Name' => 'Chris'})
      
      
      # options
      options         = args.extract_options!
      @subscriber_id  = options[:subscriber_id]
      @list_id        = options[:list_id]
      @email          = options[:email]
      @attributes     = options[:attributes] ||= []
      @account_id     = options[:account_id]
      
      # check for required options
      raise ArgumentError, "* missing :subscriber_id || (:list_id && :email) *" if (@subscriber_id.blank? && @list_id.blank? && @email.blank?) || (@subscriber_id.blank? && (@list_id.blank? || @email.blank?))
      raise ArgumentError, "* missing :subscriber_id | must include :subscriber_id if the api_method is :soap *" if @subscriber_id.blank? && @api_method == :soap
      
      # convert options
      @subscriber_id  = @subscriber_id.to_i unless @subscriber_id.blank?
      @list_id        = @list_id.to_i unless @list_id.blank?
      @account_id     = @account_id.to_i unless @account_id.blank?
      
      if @api_method == :soap
        if true # wrap
          session = Savon::Client.new(@api_wsdl)
          session.wsse.username = @username
          session.wsse.password = @password

          @attributes = @attributes.map{|name, value| {"wsdl:Name" => "#{name}", "wsdl:Value" => "#{(value.is_a?(Array)) ? value.join(',') : value}"} }
        
          soap_input = 'wsdl:UpdateRequest'
          if !@list_id.blank?
            soap_body = {
              'wsdl:Objects' => {
                'wsdl:SubscriberKey' => @subscriber_id,
                'wsdl:Attributes' => @attributes,
                'wsdl:Lists' => {
                  'wsdl:ID' => @list_id,
                  'wsdl:Status' => 'Active'
                },
                :attributes! => {
                  'wsdl:Lists' => {'xsi:type' => 'wsdl:SubscriberList'}
                }
              
              },
              :attributes! => {
                'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
              }
            }
          else
            soap_body = {
              'wsdl:Objects' => {
                'wsdl:SubscriberKey' => @subscriber_id,
                'wsdl:Attributes' => @attributes
              },
              :attributes! => {
                'wsdl:Objects' => {'xsi:type' => 'wsdl:Subscriber'}
              }
            }
          end
        
          response = session.request(:create) do |soap|
            soap.input = soap_input
            soap.body  = soap_body
          end
        
          response = Nokogiri::XML(response.http.body).remove_namespaces!
        
          check_response(response)
        
          subscriber_id     = response.xpath("//NewID").text.to_i
          subscriber_msg    = response.xpath("//StatusMessage").text
    
          ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}")
        
          return subscriber_id
      else
        if true # wrap
          # build xml data
          data = ""
          xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
          xml.instruct!
          xml.exacttarget do
            xml.authorization do
              xml.username @username
              xml.password @password
            end
            xml.system do
              xml.system_name "subscriber"
              xml.action "edit"
              xml.search_type @subscriber_id.blank? ? "listid" : "subid"
              xml.search_value @subscriber_id.blank? ? @list_id : @subscriber_id
              xml.search_value2 @email
              xml.values do
                @attributes.each do |name, value|
                  eval("xml.#{name.gsub(' ', '__')} '#{(value.is_a?(Array)) ? value.join(',') : value}'")
                end
                xml.ChannelMemberID @account_id if ETAPI.use_s4
              end
            end
          end
      
          data_encoded = "qf=xml&xml=" + url_encode(data)
      
          response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
          check_response(response)
          response = Nokogiri::XML::Document.parse(response.read_body)
      
          subscriber_id     = response.xpath("//subscriber_description").text.to_i
          subscriber_msg    = response.xpath("//subscriber_info").text
      
          ETAPI.log("    Subscriber ID:      #{subscriber_id}\n    Subscriber Message: #{subscriber_msg}")
        
          return subscriber_id
        end
        
      end
      
    end
    
    def subscriber_delete(*args)
      #a.subscriber_delete(:subscriber_id => 241224046)
      
      # options
      options         = args.extract_options!
      @subscriber_id  = options[:subscriber_id]
      
      # check for required options
      raise ArgumentError, "* missing :subscriber_id *" if @subscriber_id.blank?
      
      # convert options
      @subscriber_id = @subscriber_id.to_i
      
      # build xml data
      data = ""
      xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
      xml.instruct!
      xml.exacttarget do
        xml.authorization do
          xml.username @username
          xml.password @password
        end
        xml.system do
          xml.system_name "subscriber"
          xml.action "delete"
          xml.search_type "subid"
          xml.search_value @subscriber_id
          xml.search_value2 nil
        end
      end
      
      data_encoded = "qf=xml&xml=" + url_encode(data)
      
      response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
      check_response(response)
      response = Nokogiri::XML::Document.parse(response.read_body)
      
      subscriber_msg    = response.xpath("//subscriber_info")
      
      ETAPI.log("    Subscriber Message: #{subscriber_msg.text}")
      
    end
    
    def subscriber_delete_from_list(*args)
      #a.subscriber_delete_from_list(:list_id => 111247, :email => 'test@test.com')
      
      # options
      options         = args.extract_options!
      @list_id        = options[:list_id]
      @email          = options[:email]
      
      # check for required options
      raise ArgumentError, "* missing :list_id *" if @list_id.blank?
      raise ArgumentError, "* missing :email *" if @email.blank?
      
      # convert options
      @list_id = @list_id.to_i
      
      # build xml data
      data = ""
      xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
      xml.instruct!
      xml.exacttarget do
        xml.authorization do
          xml.username @username
          xml.password @password
        end
        xml.system do
          xml.system_name "subscriber"
          xml.action "delete"
          xml.search_type "listid"
          xml.search_value @list_id
          xml.search_value2 @email
        end
      end
      
      data_encoded = "qf=xml&xml=" + url_encode(data)
      
      response = @api_url.post(@api_uri.path, data_encoded, @headers.merge('Content-length' => data_encoded.length.to_s))
      check_response(response)
      response = Nokogiri::XML::Document.parse(response.read_body)
      
      subscriber_msg    = response.xpath("//subscriber_info")
      
      ETAPI.log("    Subscriber Message: #{subscriber_msg.text}")
      
    end
    
  end
  
end