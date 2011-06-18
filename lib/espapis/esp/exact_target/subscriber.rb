module ESP
  
  class ExactTarget
    
    def subscriber_add(*args)
      
      options         = args.extract_options!
      @list_id        = options[:list_id]
      @email          = options[:email]
      @full_name      = options[:full_name]
      @attributes     = options[:attributes]
      @account_id     = options[:account_id]
      
      # check for required options
      raise ArgumentError, "* missing :list_id *" if @list_id.blank?
      raise ArgumentError, "* missing :email *" if @email.blank?
      raise ArgumentError, "* missing :full_name *" if @full_name.blank?
      raise ArgumentError, "* missing :account_id | [using s4] *" if ESP.exact_target_use_s4 && @account_id.blank?
      
      # convert options
      @list_id = @list_id.to_i
      template_path = @api_method.to_s + '_' + __method__.to_s
      
      # build xml file
      data = ""
      xml = Builder::XmlMarkup.new(:target => data, :indent => 2)
      xml.system do
        xml.system_name "subscriber"
        xml.action "add"
        xml.search_type "listid"
        xml.search_value @list_id
        xml.search_value2 nil
        xml.values do
          xml.Email__Address @email
          xml.status "active"
          @attributes.each do|name, value|
            eval("xml.#{name} '#{(value.is_a?(Array)) ? value.join(',') : value}'")
          end
        end
        xml.update true
      end
      
      ESP.log(data)
      
    end
    
    
  end
  
end