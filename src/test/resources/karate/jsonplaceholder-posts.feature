Feature: JSONPlaceholder posts API - no auth needed, always runnable

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: fetching an existing post returns its content
    Given path 'posts/1'
    When method get
    Then status 200
    And match response.id == 1
    And match response.userId == '#number'
    And match response.title == '#string'

  Scenario: fetching a post id that doesn't exist returns 404
    Given path 'posts/9999'
    When method get
    Then status 404

  Scenario: creating a post returns the created resource with a new id
    Given path 'posts'
    And request { title: 'Karate practice post', body: 'Testing a POST request', userId: 1 }
    When method post
    Then status 201
    And match response.title == 'Karate practice post'
    And match response.id == '#number'
