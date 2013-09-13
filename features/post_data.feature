Feature: Shows Request Body
  In order to create a response for entity creation requests
  As The Wizard
  I want to see the request body

  Scenario: Receiving a POST from a form
    Given TheWizardOfApi is running in the browser
    When someone else makes a POST request to "/api" these values in a form:
    """
    ---
    user[email]: john@smith.com
    user[password]: P@ssw0rd
    user[password_confirmation]: P@ssw0rd
    """
    Then I should see:
    """
    POST /api HTTP/1.1
    Accept: */*
    User-Agent: curl
    Host: localhost:3000
    Content-Type: application/x-www-form-urlencoded

    user[email]=john@smith.com&user[password]=P@ssw0rd&user[password_confirmation]=P@ssw0rd
    """
