Feature: Generate a working Jekyll-based website
  In order to reduce cost of creating a new website for a project
  As a project developer/marketer
  I want a Jekyll-based website generated

  Scenario: Generate a site with default theme
    Given a safe folder
    When I run local executable 'jekyll_generator' with arguments 'website'
    Then folder 'website' is created
    And folder 'website/_posts' is created
    And folder '_site' is not created
    And does invoke generator 'plain_theme'
    And output does not match /General Options:/
    When I run executable 'jekyll' with arguments ''
    Then folder '_site' is created
    And file '_site/index.html' is created
    
