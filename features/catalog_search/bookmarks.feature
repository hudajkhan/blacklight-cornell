@bookmarks
Feature: Bookmarks for anonymous users
    I want to be sure anonymous users can cite, export, and print selected items

    @javascript
    @bookmarks_exists
    @saml_on
    Scenario: Does the bookmarks page exist
        When I literally go to bookmarks
        Then I should be on 'the bookmarks page'
        Then Sign in should link to Book Bags 
        And I should see a link "Selected Items"

    @javascript
    @saml_on
    @bookmarks_sign_in
    Scenario: If I try to sign in, I have to log in
        #Given PENDING Piwik javascript variable _paq is undefined
        When I go to the home page
        And I expect Javascript _paq to be defined
        When I literally go to bookmarks
        And I expect Javascript _paq to be defined
        And click on link "Sign in"
        Then I should see the CUWebLogin page

    @bookmarks
    @bookmarks_select_items
    @javascript
    @bookmarks_select_items
    Scenario Outline: I can see the count of my selected items
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results    
        And there should be 0 items selected
        Then I select the first <count> catalog results
        When I literally go to bookmarks
        And there should be <count> items selected

    Examples:
    | count |
    | 1 |
    | 2 |
    | 3 |
    | 4 |
    | 5 |
    
    @bookmarks
    @bookmarks_sign_in_links
    @javascript
    @saml_on
    @bookmarks_sign_in_links
    Scenario: I should log in via Book_bags from the Bookmarks page
        Given I am on the home page
        Then Sign in should link to the SAML login system
        When I literally go to search_history
        Then Sign in should link to the SAML login system
        When I literally go to advanced
        Then Sign in should link to the SAML login system
        When I literally go to bookmarks
        Then Sign in should link to Book Bags 

    @javascript
    @bookmarks_cite_selected
    Scenario: I should be able to view citations for selected items
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results    
        Then I select the first 3 catalog results
        When I view my selected items
        Then I should be on 'the bookmarks page'
        And there should be 3 items selected
        Then I should see the text "Selected Items"
        And I should not see the text "You have no selected items."
        Then I should see the text "Cite"
        And I view my citations
        Then the popup should include "APA 6th ed."
        And the popup should include "Chicago 17th ed."
        And the popup should include "MLA 7th ed."
        And the popup should include "MLA 8th ed."

    @javascript
    @bookmarks_export_selected
    Scenario Outline: I should be able to export selected bookmarks
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results    
        Then I select the first 3 catalog results
        When I view my selected items
        Then I should be on 'the bookmarks page'
        And there should be 3 items selected
        Then I should see the text "Selected Items"
        And I should not see the text "You have no selected items."
        And click on link "Export"
        And click on link "<item>"
        Then the popup should include "<filename>"

    Examples:
    | item | filename |
    | RIS | endnote.ris |
    | EndNote | endnote.endnote |
    | EndNote XML | endnote.endnote_xml |


    @javascript
    @bookmarks_print_selected
    Scenario: I should be able to view citations for selected items
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results    
        Then I select the first 3 catalog results
        When I view my selected items
        Then I should be on 'the bookmarks page'
        And there should be 3 items selected
        Then I should see the text "Selected Items"
        And I should not see the text "You have no selected items."
        And click on link "Print"
        Then the popup should include "Print"
        And the popup should include "Cancel"

