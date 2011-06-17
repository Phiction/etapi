
require("espapis/global")
require("espapis/esps/error")
require("espapis/esps/exact_target")
require("builder")
require("nokogiri")
require("rubygems")
gem 'activesupport'
require 'active_support'

module ESP
  extend Global
  
  def self.configure
    yield self if block_given?
  end
  
end
