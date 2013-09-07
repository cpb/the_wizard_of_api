Feature: The Wizard sees all requests
  In order to create the illusion of a service
  As The Wizard
  I want to see all the requests coming to me so that I may respond

  Scenario: A GET request to the default mount point
    Given TheWizardOfApi is running with defaults
    When someone else makes a GET request to "/api"
    Then I should see:
    """
    GET /api HTTP/1.1
    Accept: */*
    User-Agent: curl
    Host: localhost:3000
    """

  Scenario: A POST request to the Wizard's response mount point
    Given TheWizardOfApi is running with defaults
    And someone else makes a GET request to "/api"
    When I respond with:
    """
    {"dorothy": "You may have your wish"}
    """
    Then they should see:
    """
    {"dorothy": "You may have your wish"}
    """

