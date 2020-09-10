Feature: Profile
    All of the information from the profile should be editable.

    Scenario: Social Media
      Given I head to the "Profile" page
      Then I expect there to be 3 social medias

    Scenario: Removing Social Media
      Given I head to the "Profile" page
      When I tap the "twitter" button 1 times
      Then I expect there to be 2 social medias

    Scenario: Tags
      Given I head to the "Profile" page
      Then I expect there to be 3 Programming Languages

    Scenario: Adding a Tag
      Given I head to the "Profile" page
      When I add "Kotlin" to the languages
      Then I expect there to be 4 Programming Languages
      
    Scenario: Removing a Tag
      Given I head to the "Profile" page
      When I remove Programming Language number 2
      Then I expect there to be 2 Programming Languages
