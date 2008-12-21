class JekyllGeneratorGenerator < RubiGen::Base

  default_options :author => 'FIXME', :email => 'FIXME'

  attr_reader :author, :email, :title, :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name             = base_name
    @title            = base_name.humanize
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      # Create stubs
      # m.template "template.rb",  "some_file_after_erb.rb"
      # m.template_copy_each ["template.rb", "template2.rb"]
      # m.file     "file",         "some_file_copied"
      # m.file_copy_each ["path/to/file", "path/to/file2"]
    end
  end

  protected
    def banner
      <<-EOS
Creates a Jekyell static website including Disqus comment system.

USAGE: #{spec.name} path/to/website
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      opts.on("-a", "--author=\"Your Name\"", String,
              "Your name will be pre-populated throughout website",
              "Default: FIXME") { |v| options[:author] = v }
      opts.on("-e", "--email=\"your@email.com\"", String,
              "Your email will be pre-populated throughout website",
              "Default: FIXME") { |v| options[:email] = v }
      opts.on("-t", "--title=\"Your Project\"", String,
              "Your project's human title",
              "Default: current folder name") { |v| options[:title] = v }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      _posts
      layouts
      css
      images
    )
end
