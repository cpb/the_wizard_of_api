require 'restclient'

Given(/^TheWizardOfApi is running with defaults$/) do
  unset_bundler_env_vars

  write_file("Gemfile", <<-GEMFILE)
    gem 'the_wizard_of_api', path: '../../'
  GEMFILE

  write_file("config.ru",<<-RACKUP)
    require 'bundler/setup'
    require 'the_wizard_of_api'
    run TheWizardOfApi.new
  RACKUP

  run_simple("bundle")

  run_process(start: thin("-R config.ru start"),
              stop: thin("-R config.ru stop"))

  until thin_pid_path.exist?
    $stdout.write('.') if ENV['DEBUG']
  end

  visit throne_url
end

When(/^someone else makes a GET request to "(.*?)"$/) do |path|
  last_response = avoid_timing_errors do
    RestClient.get("localhost:3000#{path}")
  end
end

Then(/^I should see:$/) do |string|
  expect(page).to have_text(string)
end
