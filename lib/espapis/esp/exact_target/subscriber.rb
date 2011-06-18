module ESP
  
  class ExactTarget
    
    def subscriber_add(*args)
      
      options       = args.extract_options!
      list_id       = options[:list_id]
      email_address = options[:email_address]
      full_name     = options[:full_name]
      attributes    = options[:attributes]
      
      # check for required options
      raise ArgumentError, "* missing :list_id *" if list_id.blank?
      raise ArgumentError, "* missing :email_address *" if email_address.blank?
      raise ArgumentError, "* missing :full_name *" if full_name.blank?
      
      # convert options
      list_id = list_id.to_i
      template_path = @api_method.to_s + '_' + __method__.to_s
      
      render_xml_template(template_path)
      
      
    end
    
    
  end
  
end