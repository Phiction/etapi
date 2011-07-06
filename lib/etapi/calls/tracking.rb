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
      @parameters = {
        "search_type"   => "jobID",
        "search_value"  => @job_id,
        "search_value2" => ""
      }
      
      build_call("tracking", "retrieve")
      
    end
    
  end
  
end