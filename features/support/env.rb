require 'aruba/cucumber'
require 'capybara/cucumber'
require 'capybara-webkit'

Capybara.default_driver = :webkit

$: << "./features/support/"


require 'thin_helper'
Before("@thin",&ThinHelper::Before)
After("@thin",&ThinHelper::After)

require 'debugging_pry_helper'
After(&DebuggingPryHelper::After)

require 'timing_error_helper'

require 'process_helper'
After(&ProcessHelper::After)

require 'the_wizard_of_api_helper'
Before(&TheWizardOfApiHelper::Before)

require 'curl_helper'

World(CurlHelper,
      DebuggingPryHelper,
      ProcessHelper,
      ThinHelper,
      TimingErrorHelper,
      TheWizardOfApiHelper)
