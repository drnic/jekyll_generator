Feature: Generate a working Jekyll-based website
  In order to reduce cost of creating a new website for a project
  As a project developer/marketer
  I want a Jekyll-based website generated

  Scenario: Generate a site with default theme
    Given a project folder 'myproject'
    And I make it a git repository with origin remote 'git@github.com:myname/myproject.git'
    When I run local executable 'jekyll_generator' with arguments 'website --title "My Project"'
    Then folder 'website' is created
    And folder 'website/_posts' is created
    And file 'website/index.markdown' is created
    And contents of file 'website/index.markdown' does match /http:\/\/github.com\/myname\/myproject/
    And file 'website/atom.xml' is created
    And contents of file 'website/atom.xml' does match /http:\/\/myname.github.com\/myproject/
    And file 'website/_layouts/default.html' is created
    And contents of file 'website/_layouts/default.html' does match /My Project/
    And contents of file 'website/_layouts/default.html' does match /http:\/\/github.com\/myname\/myproject/
    And file 'website/_layouts/post.html' is created
    And contents of file 'website/_layouts/default.html' does match /My Project/
    And contents of file 'website/_layouts/post.html' does match /http:\/\/github.com\/myname\/myproject/
    And file 'website/css/stylesheet.css' is created
    And contents of file 'website/css/stylesheet.css' does not match /background:\s#;/
    And folder 'website/_site' is not created
    And does invoke generator 'plain_theme'
    And output does not match /General Options:/
    When I run executable 'jekyll' with arguments 'website website/_site'
    Then folder 'website/_site' is created
    And file 'website/_site/index.html' is created
  
  Scenario: Site with default theme has posts
    Given a project folder 'myproject'
    And I make it a git repository with origin remote 'git@github.com:myname/myproject.git'
    When I run local executable 'jekyll_generator' with arguments 'website --title "My Project"'
    And I create a blog post
    And I run executable 'jekyll' with arguments 'website website/_site'
    Then blog post HTML file is created
    
  Scenario: Site with underscored name should have hyphenated disqus name
    Given a project folder 'my_project'
    And I make it a git repository with origin remote 'git@github.com:myname/my_project.git'
    When I run local executable 'jekyll_generator' with arguments 'website --title "My Project"'
    Then contents of file 'website/_layouts/default.html' does match /disqus.com\/forums\/my-project/
    And contents of file 'website/_layouts/post.html' does match /disqus.com\/forums\/my-project/
    
  Scenario: Generate a site with textmate theme
    Given a project folder 'myproject'
    And I make it a git repository with origin remote 'git@github.com:myname/myproject.git'
    When I run local executable 'jekyll_generator' with arguments 'website --theme textmate --title "My Project"'
    Then folder 'website' is created
    And file 'website/_layouts/default.html' is created
    And contents of file 'website/_layouts/default.html' does match /My Project/
    And contents of file 'website/_layouts/default.html' does match /http:\/\/github.com\/myname\/myproject/
    And file 'website/_layouts/post.html' is created
    And contents of file 'website/_layouts/default.html' does match /My Project/
    And contents of file 'website/_layouts/post.html' does match /http:\/\/github.com\/myname\/myproject/
    And file 'website/css/macromates.css' is created
    And folder 'website/_site' is not created
    And does invoke generator 'textmate_theme'
    And output does not match /General Options:/
    When I run executable 'jekyll' with arguments 'website website/_site'
    Then folder 'website/_site' is created
    And file 'website/_site/index.html' is created

  Scenario: Site with default theme has posts
    Given a project folder 'myproject'
    And I make it a git repository with origin remote 'git@github.com:myname/myproject.git'
    When I run local executable 'jekyll_generator' with arguments 'website --theme textmate --title "My Project"'
    When I create a blog post
    When I run executable 'jekyll' with arguments 'website website/_site'
    Then blog post HTML file is created
