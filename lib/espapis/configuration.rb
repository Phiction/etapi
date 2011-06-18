require("logger")
require("net/https")
require("espapis/esps/exact_target")

module ESP
  module Configuration
    
    attr_accessor(
      :exact_target_username,
      :exact_target_password,
      :exact_target_api_method,
      :exact_target_use_s4
    )
    
    # Creates ESP.log = {value}
    attr_writer(:log)
    
    # Returns whether to log. (true)
    def log?
     @log != false
    end
    
    # Creates ESP.logger = {value}
    attr_writer(:logger)
    
    # Returns the logger. (::Logger.new(STDOUT))
    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
    
    # Creates ESP.log_level = {value}
    attr_writer(:log_level)
    
    # Returns the log level. (:debug)
    def log_level
      @log_level ||= :debug
    end
    
    # Logs the passed message.
    def log(message)
     logger.send(log_level, "\n\n#{message}\n\n") if log?
    end
    
    # Creates ESP.log = {value}
    attr_writer(:raise_errors)
    
    # Returns whether to raise errors. (true)
    def raise_errors?
      @raise_errors != false
    end
    
  end
end