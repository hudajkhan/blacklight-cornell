Feature: Facets

	In order to refine my search results
	As a user
	I want to use facets for different search parameters.

	Background:

	@homepage
    @javascript
	Scenario: Viewing the home page
		Given I am on the home page
		Then I should see a facet called 'Access'
		And I should see a facet called 'Format'
		And I should not see a facet called 'Author, etc.'
		And I should not see a facet called 'Publication Year'
		And I should see a facet called 'Language'
		#And I should not see a facet called 'Subject/Genre'
		And I should not see a facet called 'Subject: Region'
		And I should not see a facet called 'Subject: Era'
		And I should not see a facet called 'Fiction/Non-Fiction'
		And I should see a facet called 'Library Location'
		And I should not see a facet called 'Call Number'
		And I should see only the first 10 Format facets

		And the 'Access' facet should not be open
		# DISCOVERYACCESS-? 'Format' facet should always be open
		And the 'Format' facet should be open
		And the 'Language' facet should not be open

	@homepage
	@nocallnumber
    @javascript
	Scenario: Viewing the home page
		Given I am on the home page
		And I should not see a facet called 'Call Number'

	@DISCOVERYACCESS-7221
	Scenario Outline: Facet counts in search for everything
		Given I am on the home page
		And I search for everything
		Then the count for category '<category>' facet '<facet>' should be '<count>'
		And I choose category '<category>' facet '<facet>'
		Then I should get <count> results

	Examples:
		| category | facet | count |
		| Access | At the Library  | 181  |
		| Format | Book | 166 |
		| Author, etc. | Rowling, J. K. | 8 |
		| Language | English | 169 |
		| Subject | Magic | 8 |
		| Subject: Region | United States | 25 |
		| Subject: Era | 1900 - 1999 | 5 |
		| Genre | Periodicals | 26 |
		| Fiction/Non-Fiction | Non-Fiction (books) | 136 |
		| Date Acquired | Since last year | 4 |


	@DISCOVERYACCESS-7221
	Scenario Outline: Facet counts in search for everything special
		Given I am on the home page
		And I search for everything
		And I choose category '<category>' link '<facet>'
		Then I should get <count> results

	Examples:
		| category | facet | count |
		| Publication Year | Unknown | 3 |
		| Library Location | Adelson Library | 2 |
		| Call Number | A - General | 8 |

	@DISCOVERYACCESS-7855
	Scenario Outline: Handling valid Publication Year date ranges
		Given I am on the home page
		And I search for everything
		Then I limit the publcation year from <begin> to <end>
		Then I should get <count> results
		And I should not see 'Publication Year facet out of range'

	Examples:
		| begin | end | count |
		| 1600 | 2010 | 187 |
		| 1910 | 1950 | 24 |

	@DISCOVERYACCESS-7855
	Scenario Outline: Handling invalid Publication Year date ranges
		Given I am on the home page
		And I search for everything
		Then I limit the publcation year from <begin> to <end>
		And I should see 'Publication Year facet out of range'

	Examples:
		| begin | end | count |
		| -1 | 2010 | 187 |
		| 1910 | -4 | 24 |
		| 1966 | 1800 | 2 |

	@DISCOVERYACCESS-7869
	Scenario Outline: Each facet should have it's own Facet page
		Given I visit the facet page for '<facet>'
		Then I should not see 'NoMethodError'
		And I should see '<facet_label>'

	Examples:
		| facet | facet_label |
		| online | Access |
		| format | Format |
		| author_facet | Author, etc. |
		| pub_date_facet | Publication Year |
		| workid_facet | Work |
		| language_facet | Language |
		| fast_topic_facet | Subject |
		| fast_geo_facet | Subject: Region |
		| fast_era_facet | Subject: Era |
		| fast_genre_facet | Genre |
		| subject_content_facet | Fiction/Non-Fiction |
		| lc_alpha_facet | Call Number |
		| location_facet | Library Location |
		| location | Library Location |
		| hierarchy_facet | No Label Given |
		| authortitle_facet | Author-Title |
		| lc_callnum_facet | Call Number |
		| collection | No Label Given |
		| acquired_dt_query | Date Acquired |