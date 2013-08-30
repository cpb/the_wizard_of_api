TheWizardOfApi
===

[Wizard of Oz experiments](http://en.wikipedia.org/wiki/Wizard_of_Oz_experiment) help early on in the [design of novel services](http://www.deaneckles.com/blog/305_aardvarks-use-of-wizard-of-oz-prototyping-to-design-their-social-interfaces/).

From [Usability Net](http://www.usabilitynet.org/tools/wizard.htm)

> The Wizard of Oz technique enables unimplemented technology to be evaluated by using a human to simulate the response of a system.

TheWizardOfApi helps you build Wizard of Oz experiments by providing a human an interface that enables them to create API responses for incoming requests. Keeping with the metaphore, this interface is called the Throne Room. The human operator, or Wizard, observes incoming HTTP requests, and uses a form to create a JSON response document.

## Installation

Add this line to your application's Gemfile:

    gem 'the_wizard_of_api'

And then execute:

    $ bundle

### In an existing Rack app

Add this to your config.ru file:

    require 'the_wizard_of_api'
    use TheWizardOfApi
    # Counts on having a run statement

### As a stand alone Rack app

Start your config.ru file like this:

    require 'bundler/setup'
    require 'the_wizard_of_api'
    run TheWizardOfApi.new

## Usage

Having installed TheWizardOfApi to your Rack application, you can now access the Throne Room in your favoured browser at http://localhost:3000/throne

By default, TheWizardOfApi mounts the API request handler at a wild card path starting with /api/. So, requests like

* POST /api/wishes
* GET /api/wish/heart
* PUT /api/dorothy/home
* DELETE /api/witches

are satisifed by TheWizardOfApi. You can customize the mount point in your Rackup file like so:

     use TheWizardOfApi, mount: "/kansas"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
