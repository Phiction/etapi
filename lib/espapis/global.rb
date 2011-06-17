require("logger")
require("active_support/core_ext/object/blank")
require("net/https")

module ESP
  module Global
    
    # Sets whether to log HTTP requests.
    attr_writer :log
    
    # Returns whether to log HTTP requests. Defaults to +true+.
    def log?
     @log != false
    end
    
    # Sets the logger to use.
    attr_writer :logger
    
    # Returns the logger. Defaults to an instance of +Logger+ writing to STDOUT.
    def logger
      @logger ||= ::Logger.new STDOUT
    end
    
    # Sets the log level.
    attr_writer :log_level
    
    # Returns the log level. Defaults to :debug.
    def log_level
      @log_level ||= :debug
    end
    
    # Logs a given +message+.
    def log(message)
     logger.send(log_level, "\n\n#{message}\n\n") if log?
    end
    
    # Sets whether to raise HTTP errors and SOAP faults.
    attr_writer :raise_errors
    
    # Returns whether to raise errors. Defaults to +true+.
    def raise_errors?
      @raise_errors != false
    end
    
    # Sets whether to enable ExactTarget
    attr_writer :exact_target_enabled
    
    # Sets whether ExactTarget is enabled or not
    def exact_target_enabled?
      @exact_target_enabled != false
    end
    
  end
end