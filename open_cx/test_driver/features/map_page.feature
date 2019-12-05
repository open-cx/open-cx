Feature: Open Map
  The map should be open when a menu button is clicked or the menu map slide button is clicked.

  Scenario: Map appears when Map slide button is clicked
    Given I expect the "Home page" to be visible
    When I tap the "map slide button" button
    Then I expect the "Map page" to be visible

  Scenario: Map appears when Menu button is clicked
    Given I expect the "Home page" to be visible
    When I tap the "nearest poi button" button
    Then I expect the "Map page" to be visible