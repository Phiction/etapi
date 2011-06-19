require("etapi/configuration")

module ETAPI
  extend Configuration
  
  def self.configure
    yield self if block_given?
  end
  
end
