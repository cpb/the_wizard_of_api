Feature: The Wizard sees all requests
  In order to create the illusion of a service
  As The Wizard
  I want to see all the requests coming to me

  Scenario: A GET request to the default mount point
    Given TheWizardOfApi is running with defaults
    When someone else makes a GET request to "/api"
    Then I should see:
    """
    GET / HTTP/1.1
    Accept: */*; q=0.5, application/xml
    Accept-Encoding: gzip, deflate
    User-Agent: Ruby
    Host: 0.0.0.0:9292
    """

