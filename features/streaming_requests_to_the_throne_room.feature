Feature: The Wizard sees all requests
  In order to create the illusion of a service
  As The Wizard
  I want to see all the requests coming to me

  Scenario: A GET request to the default mount point
    Given TheWizardOfApi is running with defaults
    When someone else makes a GET request to "/api"
    Then I should see:
    """
    GET /api HTTP/1.1
    Accept: */*
    User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8x zlib/1.2.5
    Host: localhost:3000
    """

