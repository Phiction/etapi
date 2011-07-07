module ETAPI
  
  class Session
    
    def list_retrieve_subscribers(*args)
      
      # options
      options         = args.extract_options!
      @list_id        = options[:list_id]
      
      # check for required options
      required_options = ["list_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      @parameters = {
        "search_type"   => "listid",
        "search_value"  => @list_id
      }
      
      response = build_call("list", "retrieve_sub", {:parse_response => false})
      Hash.from_xml(response)['exacttarget']['system']['list']['subscribers'].first[1] rescue false
      
    end
    
  end
  
end