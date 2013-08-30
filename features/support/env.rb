require 'aruba/cucumber'
require 'capybara/cucumber'
require 'capybara-webkit'

Capybara.default_driver = :webkit

$: << "./features/support/"


require 'thin_helper'
After("@thin",&ThinHelper::After)

require 'debugging_pry_helper'
After(&DebuggingPryHelper::After)

require 'timing_error_helper'

World(DebuggingPryHelper, ThinHelper, TimingErrorHelper)
