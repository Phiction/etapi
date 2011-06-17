module ESP
  module ExactTarget
    module Render

      def path(name)
        File.join((@path || File.dirname(__FILE__)), "#{name}.rxml")
      end
    
      def render(name)
        erb = ERB.new( File.open(path(name) ,"r").read, 0, "<>")
        erb.result( binding )
      end
    
    end
  end
end