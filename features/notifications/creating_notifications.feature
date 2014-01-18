Feature: Admin Creates a Notification
As an admin
In order to inform people of an emergency
I want to create a notification that uses many channels

This is a high level feature description of creating a Notification

Abilities when creating a Notification:
 Select a topic from DCM
 Select a e911 list
 Select by geography
 Select by subscriber meta data filters
 Select by standard DCM filters

Customize notification text for Email, SMS, Phone, Facebook, Twitter and RSS

Schedule the sending

Preview the message in for each channel

Send the notification

View metrics of recipients

Scenario: Selecting a topic list from DCM
Given I have an account with a dcm account code: "HAL"
And I have a dcm account with a topic "Ice Cream"
When I create a new notification
And I select "Ice Cream" from "DCM Topics"
Then I should be able to schedule the notification
And I should be able to send the notification

Scenario: Selecting a topic without DCM enabled
Given I have an account without a dcm account
When I create a new notification
Then I should not see "DCM Topics"
