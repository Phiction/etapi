module ETAPI
  
  class Session
    
    def subscriber_add(*args)
      
      # options
      options           = args.extract_options!
      @list_id          = options[:list_id] ||= nil
      @email            = options[:email]
      @values           = options[:values] ||= {}
      @account_id       = options[:account_id]
      
      # check for required options
      required_options = ["email"]
      required_options += ["list_id"] if @api_method == :xml
      return false unless check_required(required_options)
      
      # update options
      @values.merge!({"Email Address" => @email, "status" => "active"})
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "listid",
        "search_value"  => @list_id,
        "search_value2" => "",
        "values"        => @values
      }
      
      response = build_call("subscriber", "add")
      response.xpath("//subscriber_description").text.to_i rescue false
      
    end
    
    def subscriber_edit(*args)
      
      # options
      options         = args.extract_options!
      @subscriber_id  = options[:subscriber_id]
      @values         = options[:values] ||= {}
      @account_id     = options[:account_id] ||= ""
      
      # check for required options
      required_options = ["subscriber_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "subid",
        "search_value"  => @subscriber_id,
        "search_value2" => "",
        "values"        => @values
      }
      
      response = build_call("subscriber", "edit")
      response.xpath("//subscriber_description").text == @subscriber_id.to_s rescue false
      
    end
    
    def subscriber_edit_from_list(*args)
      
      # options
      options         = args.extract_options!
      @list_id        = options[:list_id]
      @email          = options[:email]
      @values         = options[:values] ||= {}
      @account_id     = options[:account_id] ||= ""
      
      # check for required options
      required_options = ["list_id", "email"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "listid",
        "search_value"  => @list_id,
        "search_value2" => @email,
        "values"        => @values
      }
      
      response = build_call("subscriber", "edit")
      response.xpath("//subscriber_description").text.blank? && response.xpath("//subscriber_info").text.blank? ? false : true rescue false
      
    end
    
    def subscriber_delete(*args)
      
      # options
      options         = args.extract_options!
      @subscriber_id  = options[:subscriber_id]
      
      # check for required options
      required_options = ["subscriber_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "subid",
        "search_value"  => @subscriber_id,
        "search_value2" => ""
      }
      
      response = build_call("subscriber", "delete")
      response.xpath("//subscriber_info").text.blank? ? false : true rescue false
      
    end
    
    def subscriber_remove_from_list(*args)
      
      # options
      options         = args.extract_options!
      @list_id        = options[:list_id]
      @email          = options[:email]
      
      # check for required options
      required_options = ["list_id", "email"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "listid",
        "search_value"  => @list_id,
        "search_value2" => @email
      }
      
      response = build_call("subscriber", "delete")
      response.xpath("//subscriber_info").text.blank? ? false : true rescue false
      
    end
    
    def subscriber_unsubscribe_master(*args)
      
      # options
      options         = args.extract_options!
      @email          = options[:email]
      
      # check for required options
      required_options = ["email"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "emailaddress",
        "search_value"  => {
          "emailaddress" => @email
        }
      }
      
      response = build_call("subscriber", "masterunsub")
      response.xpath("//emailaddress").text == @email ? true : false rescue false
      
    end
    
    def subscriber_retrieve(*args)
      
      # options
      options         = args.extract_options!
      @subscriber_id  = options[:subscriber_id]
      @account_id     = options[:account_id] ||= ""
      
      # check for required options
      required_options = ["subscriber_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "subid",
        "search_value"  => @subscriber_id,
        "search_value2" => ""
      }
      
      response = build_call("subscriber", "retrieve", {:parse_response => false})
      Hash.from_xml(response)['exacttarget']['system']['subscriber'] rescue false
      
    end
    
  end
  
end