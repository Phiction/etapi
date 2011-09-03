module ETAPI
  
  class Session
    
    def tracking_retrieve(*args)
      
      # options
      options         = args.extract_options!
      @job_id         = options[:job_id]
      
      # check for required options
      required_options = ["job_id"]
      return false unless check_required(required_options)
      
      # merge parameters and values
      type        = "tracking"
      method      = "retrieve"
      @parameters = {
        "search_type"   => "jobID",
        "sub_action"    => "summary",
        "search_value"  => @job_id,
        "search_value2" => ""
      }
      
      response = build_call(type, method, {:parse_response => false})
      Hash.from_xml(response)['exacttarget']['system']['tracking']['emailSummary'] rescue false
      
    end
    
  end
  
end