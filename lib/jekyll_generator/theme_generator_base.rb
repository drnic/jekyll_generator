class JekyllGenerator::ThemeGeneratorBase < RubiGen::Base
  # these values are automatically setup by the config.yml file
  # generated from jekyll_generator_generator.rb
  # based on options/defaults
  attr_reader :author, :email, :title, :name, :theme, :github_user, :header_color
  attr_reader :hypenated_name

  def initialize(runtime_args, runtime_options = {})
    super
    config_options = YAML.load(File.read(File.join(destination_root, "config.yml")))
    config_options.each do |key, value|
      self.send(:instance_variable_set, "@#{key}", value)
    end
    
    @hypenated_name = @name.gsub(/_/, '-')
  end
  
  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory '_layouts'
      m.directory 'css'

      m.template_copy_each ["default.html", "post.html"], "_layouts"
      m.template_copy_each ["stylesheet.css"], "css"
    end
  end
end