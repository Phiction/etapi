require("erb")
require("uri")
require("logger")
require("builder")
require("nokogiri")
require("net/https")
require("etapi/exact_target")

include(ERB::Util)

module ETAPI
  module Configuration
    
    attr_accessor(
      :username,
      :password,
      :api_method,
      :use_s4
    )
    
    # Creates ETAPI.log = {value}
    attr_writer(:log)
    
    # Returns whether to log. (true)
    def log?
     @log != false
    end
    
    # Creates ETAPI.logger = {value}
    attr_writer(:logger)
    
    # Returns the logger. (::Logger.new(STDOUT))
    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
    
    # Creates ETAPI.log_level = {value}
    attr_writer(:log_level)
    
    # Returns the log level. (:debug)
    def log_level
      @log_level ||= :debug
    end
    
    # Logs the passed message.
    def log(message)
     logger.send(log_level, "\n#{message}\n") if log?
    end
    
    # Creates ETAPI.log = {value}
    attr_writer(:raise_errors)
    
    # Returns whether to raise errors. (true)
    def raise_errors?
      @raise_errors != false
    end
    
  end
end