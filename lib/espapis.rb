require("espapis/global")
require("espapis/template")
require("espapis/esps/exact_target")

module ESP
  extend Global
  
  def self.configure
    yield self if block_given?
  end
  
end
