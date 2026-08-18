Feature: GoRest users API - CRUD and CSV-driven data test
  # Needs your own free token: gorest.co.in/my-account/access-tokens
  # export GOREST_TOKEN=<your token> before running, or pass -Dgorest.token=<token>.
  # Without a real token these scenarios fail with 401 - expected, not a bug.

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Authorization = 'Bearer ' + gorestToken
    * header Content-Type = 'application/json'

  Scenario: listing users succeeds
    Given path 'users'
    When method get
    Then status 200

  Scenario: creating a user returns the created resource
    * def randomEmail = 'karate.demo.' + Math.floor(Math.random() * 1000000) + '@mail.com'
    Given path 'users'
    And request { name: 'Karate Demo User', gender: 'male', email: '#(randomEmail)', status: 'active' }
    When method post
    Then status 201
    And match response.name == 'Karate Demo User'
    And match response.status == 'active'

  Scenario: fetching a user id that doesn't exist returns 404
    Given path 'users', 999999999
    When method get
    Then status 404

  Scenario Outline: creating several users from a CSV file
    * def randomSuffix = Math.floor(Math.random() * 1000000)
    Given path 'users'
    And request { name: '<name>', email: '<email>' + randomSuffix + '@mail.com', gender: '<gender>', status: '<status>' }
    When method post
    Then status 201
    And match response.name == '<name>'
    And match response.status == '<status>'

    Examples:
      | read('data/users.csv') |
