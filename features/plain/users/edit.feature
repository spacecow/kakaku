Scenario: Address should be filled in if there is one
Given an address exists with zip: "9800815", prefecture: "宮城県", ward: "青葉区", area: "花壇"
	And a user: "reiko" exists with username: "reiko", address: that address
	And I am logged in as "reiko"
When I go to the edit page of user "reiko"
Then the "user_address_attributes_zip3" field should contain "980"
	And the "user_address_attributes_zip4" field should contain "0815"
	And "宮城県" should be selected in the "Prefecture" field