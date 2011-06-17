require("espapis/configuration")

module ESP
  extend Configuration
  
  def self.configure
    yield self if block_given?
  end
  
end
