class JekyllGeneratorGenerator < RubiGen::Base

  default_options :theme => 'plain'

  attr_reader :title, :name, :theme, :github_user, :header_color

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name             = base_name
    extract_options
    @title ||= base_name.humanize
    @header_color ||= random_color

    remote_origin_url = `git config remote.origin.url`
    if remote_origin_url.size > 0 && matches = remote_origin_url.match(/git@github.com:(.*)\/(.*).git/)
      @github_user, @name = matches[1..2]
      options[:github_user] ||= @github_user
    end
    options[:name] ||= @name
    options[:header_color] ||= @header_color
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
      opts.on("--header-color=rrggbb", String,
              "Color for your theme's header (if theme permits header color selection)",
              "Default: random") { |v| options[:header_color] = v }
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
      @theme        = options[:theme]
      @header_color = options[:header_color]
      @title        = options[:title]
    end
    
    def random_color
      colors = ['aaa', # light grey
        'C7E9B7', # background from http://jsunittest.com/
        '8DBD82', # background from http://newgem.rubyforge.org/
        'E9C000', # background from http://drnicjavascript.rubyforge.org/github_badge/
        '4D606C', # header background from http://disqus.com/people/drnic/
        'FF6633', # orangy color
        'FF6633', # dark blue color
      ]
      colors[rand(colors.length)]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      _posts
    )
end
