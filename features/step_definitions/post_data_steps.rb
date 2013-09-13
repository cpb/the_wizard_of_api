require 'uri'

When(/^someone else makes a POST request to "(.*?)" these values in a form:$/) do |path, string|
  last_response = avoid_timing_errors do
    dorothy_request(path, :post,
                    "Content-Type" => "application/x-www-form-urlencoded",
                    "Body" => URI::encode_www_form(YAML::load(string)))
  end
end
