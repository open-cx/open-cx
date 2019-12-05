Feature: Map Filters
  The map filters should appear when the button in the AppBar is pressed.

  Scenario: Map filters appear when the button is pressed
    Given I expect the "Home page" to be visible
    Given I tap the "map slide button" button
    Given I expect the "map filters" to be hidden
    When I tap the "Open navigation menu" tooltip
    Then I expect the "map filters" to be visible