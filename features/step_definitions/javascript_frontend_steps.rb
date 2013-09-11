Given(/^TheWizardOfApi is running in the browser$/) do
  unset_bundler_env_vars

  install_the_wizard_of_api

  start_the_wizard_of_api

  visit throne_url

  avoid_timing_errors do
    expect(page).to have_text("Throne Room")
  end
end

When(/^I submit a "(.*?)" with:$/) do |field, value|
  fill_in(field, with: value)
  click_on("Submit")
end
