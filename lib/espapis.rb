require "global"

module ESP
  
  def self.configure
    yield self if block_given?
  end
  
end
