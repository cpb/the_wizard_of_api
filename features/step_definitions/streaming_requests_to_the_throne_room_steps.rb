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
  # expect(page).to have_text(string)
  avoid_timing_errors do
    check_file_content("throne.log",string,true)
  end
end
