module ETAPI
  
  class Session
    
    def email_retrieve_body(*args)
      
      # options
      options         = args.extract_options!
      @email_id       = options[:email_id]
      
      # check for required options
      required_options = ["email_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "emailid",
        "sub_action"    => "htmlemail",
        "search_value"  => @email_id,
        "search_value2" => "",
        "search_value3" => "",
      }
      
      response = build_call("email", "retrieve")
      response.xpath("//htmlbody").text rescue false
      
    end
    
  end
  
end