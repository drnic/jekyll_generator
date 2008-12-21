class JekyllGeneratorGenerator < RubiGen::Base

  default_options :author => 'FIXME', :email => 'FIXME', :theme => 'plain'

  attr_reader :author, :email, :title, :name, :theme, :github_user

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name             = base_name
    @title            = base_name.humanize
    extract_options

    remote_origin_url = `git config remote.origin.url`
    if remote_origin_url.size > 0 && matches = remote_origin_url.match(/git@github.com:(.*)\/(.*).git/)
      @github_user, @name = matches[1..2]
      options[:github_user] ||= @github_user
    end
    options[:name] ||= @name
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      m.template_copy_each ["index.markdown", "atom.xml", "config.yml"]

      m.dependency "#{theme}_theme", [], :destination => destination_root, :collision => :force
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
      opts.on("-u", "--github_user=drnic", String,
              "Your github user name",
              "Default: derived from project's origin url") { |v| options[:github_user] = v }
      opts.on("--title=\"Your Project\"", String,
              "Your project's human title",
              "Default: current folder name") { |v| options[:title] = v }
      opts.on("-t", "--theme=THEME", String,
              "Initial layouts, css, images from a theme.",
              "Available: plain, textmate",
              "Default: plain") { |v| options[:theme] = v }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      @author = options[:author]
      @email  = options[:email]
      @theme  = options[:theme]

      @title  = options[:title] if options[:title]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      _posts
    )
end
