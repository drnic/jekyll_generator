Feature: Generate a working Jekyll-based website
  In order to reduce cost of creating a new website for a project
  As a project developer/marketer
  I want a Jekyll-based website generated

  Scenario: Generate a site with default theme
    Given a safe folder
    When I run local executable 'jekyll_generator' with arguments 'website'
    Then folder 'website' is created
    Then folder 'website/_posts' is created
  
