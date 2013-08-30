Then(/^I should see the "(.*?)" at "(.*?)"$/) do |expected_text, location|
  avoid_timing_errors do
    visit location
  end

  expect(page).to have_content(expected_text)
end
