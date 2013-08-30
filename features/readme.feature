Feature: The public interface documented in the README

  @disable-bundler @thin
  Scenario: First installation using Bundler in an existing Rack Application
    Given a file named "Gemfile" with:
    """
    gem 'the_wizard_of_api', path: '../../'
    """
    And a file named "config.ru" with:
    """
    require 'bundler/setup'
    require 'the_wizard_of_api'
    use TheWizardOfApi

    run Proc.new {|env| [200, {"Content-type" => "text/html"}, ["Run Rack!"]]}
    """
    And I run `bundle`
    When I successfully run `thin -d -P thin.pid -l thin.log -R config.ru start`
    Then I should see the "Throne Room" at "http://localhost:3000/throne"

  @disable-bundler @thin
  Scenario: First installation using Bundler as a stand alone Rack Application
    Given a file named "Gemfile" with:
    """
    gem 'the_wizard_of_api', path: '../../'
    """
    And a file named "config.ru" with:
    """
    require 'bundler/setup'
    require 'the_wizard_of_api'
    run TheWizardOfApi.new
    """
    And I run `bundle`
    When I successfully run `thin -d -P thin.pid -l thin.log -R config.ru start`
    Then I should see the "Throne Room" at "http://localhost:3000/throne"


