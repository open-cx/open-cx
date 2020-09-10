Feature: FriendRequest
    Acting upon Friend Requestss

    Scenario: Adding Friend
      Given I head to the "Friend-Requests" page
      When I tap the "5dfa5f24e48e96582-accept" button 1 times
      Then I find the text "Added!"

    Scenario: Adding Friend
      Given I head to the "Friend-Requests" page
      When I tap the "5dfa5f24e48e96582-accept" button 1 times
      Then I find the text "Rejected!"