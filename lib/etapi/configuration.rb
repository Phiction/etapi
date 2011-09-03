require("erb")
require("uri")
require("logger")
require("builder")
require("nokogiri")
require("net/https")
require("etapi/error")
require("etapi/exact_target")
require("etapi/call_builder")

include(ERB::Util)

module ETAPI
  module Configuration
    
    attr_accessor(
      :username,
      :password,
      :use_s4,
      :raise_errors,
      :log
    )
    
    attr_writer(:log)
    def log?
     @log != false
    end
    
    def log(message)
     logger.send(log_level, "\n#{message}\n") if log?
    end
    
    attr_writer(:logger)
    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
    
    attr_writer(:log_level)
    def log_level
      @log_level ||= :debug
    end
    
    attr_writer(:raise_errors)
    def raise_errors?
      @raise_errors != false
    end
    
  end
end