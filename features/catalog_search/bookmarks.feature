@bookmarks
@javascript
Feature: Bookmarks for anonymous users
    I want to be sure anonymous users can cite, export, and print selected items

    @bookmarks_exists
    #@saml_on
    Scenario: Does the bookmarks page exist
        When I literally go to bookmarks
        Then I should be on 'the bookmarks page'
        Then Sign in should link to Book Bags
        And I should see a link "Selected Items"

    @bookmarks_sign_in
    Scenario: If I try to sign in from bookmarks, I have to log in via book bags
        When I literally go to bookmarks
        Then Sign in should link to Book Bags

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

    #@saml_on
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

    @bookmarks_cite_selected
    Scenario: I should be able to view citations for selected items
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results
        Then I select the first 2 catalog results
        And I sleep 2 seconds
        When I view my selected items
        Then I should be on 'the bookmarks page'
        And there should be 2 items selected
        Then load 2 selected items
        And I should not see the text "You have no selected items."
        Then I should see the text "Cite"
        And I view my citations
        And I sleep 2 seconds
        Then the popup should include "APA 6th ed."
        And the popup should include "Chicago 17th ed."
        And the popup should include "MLA 7th ed."
        And the popup should include "MLA 8th ed."

    @bookmarks_export_selected
    Scenario: I should be able to export selected bookmarks
        Given I am on the home page
		When I fill in the search box with 'rope work'
		And I press 'search'
		Then I should get results
        Then I select the first 3 catalog results
        And I sleep 2 seconds
        When I view my selected items
        Then I should be on 'the bookmarks page'
        And there should be 3 items selected
        Then load 3 selected items
        Then I should see the text "Selected Items"
        And I should not see the text "You have no selected items."
        Then click on link "Export"
        And the url of link "EndNote" should contain "endnote.endnote"
        And the url of link "RIS" should contain "endnote.ris"
        And the url of link "EndNote XML" should contain "endnote.endnote_xml"


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

#    @bookmarks_select_limit
#    @javascript
#    Scenario: I should be limited to 500 selected items
#        Given PENDING
        # after many attempts to adjust timing and selection count, this just does not work reliably
#        Given I am on the home page
#		When I fill in the search box with 'shirt'
#		And I press 'search'
#        And I select 100 items per page
#        And I sleep 5 seconds
#        And I check Select all
#        And I sleep 5 seconds
#        Then I should see 100 selected items
#        And click on first link "Next »"
#        And I check Select all
#        And I sleep 5 seconds
#        Then I should see 200 selected items
#        And click on first link "Next »"
#        And I check Select all
#        And I sleep 5 seconds
#        Then I should see 300 selected items
#        And click on first link "Next »"
#        And I check Select all
#        And I sleep 10 seconds
#        Then I should see 400 selected items
#        And click on first link "Next »"
#        And I check Select all
#        And I sleep 5 seconds
#        Then I should see 500 selected items
#        And click on first link "Next »"
#        Then I select the first 1 catalog results
#        Then I should see 500 selected items

#    @bookmarks_book_select_limit
#    @javascript
#    Scenario Outline: My bookbag should be limited to 500 selected books
#        Given PENDING
        # after many attempts to adjust timing and selection count, this just does not work reliably
#        Given I visit Books page '<page>' with '50' per page
#        And I check Select all
#        And I sleep 3 seconds
#        Then I should see <count> selected items


#    Examples:
#    | page | count |
#    | 2 | 50 |
#    | 3 | 100 |
#    | 4 | 150 |
