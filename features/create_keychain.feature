Feature: User creates a keychain
  Scenario: 
    User creates a keychain successfully

    Given a logged in user
    When a user goes to the new keychain page
    And fills out a keychain with name "the keychain", description "the description here", :username => "joe", :password => "bull23right"
    And submits the new keychain form
    Then the user is redirected to the keychains listing page
    And the user can see a keychain with the name "the keychain"
