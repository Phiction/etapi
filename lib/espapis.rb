require("espapis/global")
require("espapis/error")
require("espapis/esps/exact_target")
require("builder")

module ESP
  extend Global
  
  def self.configure
    yield self if block_given?
  end
  
end
