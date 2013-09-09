Feature: Javascript form for submitting responses
  In order to create responses faster
  As The Wizard
  I want to compose the responses from a page in my browser

  Scenario: A simple request and response
    Given TheWizardOfApi is running in the browser
    And someone else makes a GET request to "/api"
    When I submit a "response" with:
    """
    Always believe in who you are Dorothy and let no one stand in your way.
    """
    Then they should see:
    """
    Always believe in who you are Dorothy and let no one stand in your way.
    """
