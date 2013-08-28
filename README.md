TheWizardOfApi
===

Enables a human-wizard to craft each response for a yet unimplemented API.

## Installation

### In an existing Rack app

Add this line to your application's Gemfile:

    gem 'the_wizard_of_api'

And then execute:

    $ bundle

Add it to your config.ru file:

    require 'the_wizard_of_api'
    use TheWizardOfApi

## Usage

Having installed TheWizardOfApi to your Rack application, you can now access the Throne Room in your favoured browser at http://localhost:3000/throne

By default, TheWizardOfApi mounts the API request handler at a wild card path starting with /api/. So, requests like

* POST /api/wishes
* GET /api/wish/heart
* PUT /api/dorothy/home
* DELETE /api/witches

Each are satisifed by TheWizardOfApi. You can customize the mount point in your Rackup file like so:

     use TheWizardOfApi, mount: "/kansas"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
