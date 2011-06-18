module ESP
  
  module Render
    
    def template_path(name)
      File.join(File.dirname(__FILE__), "esps/#{self.class.to_s}/#{name}.rxml")
    end
    
    def render_xml_template(name)
      ESP.log(template_path(name))
    end
    
  end
  
end