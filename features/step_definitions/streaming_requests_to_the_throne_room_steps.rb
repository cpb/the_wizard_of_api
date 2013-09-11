Given(/^TheWizardOfApi is running with defaults$/) do
  unset_bundler_env_vars

  install_the_wizard_of_api

  start_the_wizard_of_api

  the_wizard_takes_their_seat
end

When(/^someone else makes a GET request to "(.*?)"$/) do |path|
  last_response = avoid_timing_errors do
    dorothy_request(path)
  end
end

Then(/^I should see:$/) do |string|
  avoid_timing_errors(2) do
    expect(page).to have_text(string)
  end
end

Then(/^they should see:$/) do |string|
  avoid_timing_errors(2) do
    check_file_content(log_path("dorothy").basename,string,true)
  end
end

When(/^I respond with:$/) do |response|
  wizard_response(response)
end
