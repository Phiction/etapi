require "espapis/global"

module ESP
  extend Global
  
  def self.configure
    yield self if block_given?
  end
  
  module ExactTarget
    require("espapis/esps/exact_target") if ESP.exact_target_enabled?
  end
  
end
