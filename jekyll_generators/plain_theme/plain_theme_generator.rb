class PlainThemeGenerator < RubiGen::Base
  attr_reader :author, :email, :title, :name, :theme, :github_user

  def initialize(runtime_args, runtime_options = {})
    super
    config_options = YAML.load(File.read(File.join(destination_root, "config.yml")))
    config_options.each do |key, value|
      self.send(:instance_variable_set, "@#{key}", value)
    end
  end
  
  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory 'layouts'
      m.directory 'css'

      m.template_copy_each ["default.html", "post.html"], "layouts"
      m.file_copy_each ["stylesheet.css"], "css"
    end
  end
end