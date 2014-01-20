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

Preview the message for each channel

Send the notification

View metrics of recipients

Scenario: Selecting a topic list from DCM
Given I have an account with a dcm account code: "HAL"
And I have a dcm account with a topic "Ice Cream"
When I create a new notification
And I select "Ice Cream" from "DCM Topics"
# Then I should be able to schedule the notification
And I should be able to send the notification

@file-upload
Scenario: Selecting a e911 list
Given I am logged in as an account admin
When I upload a file named "chicago.csv" that contains:
| action | record_id | salutation | first_name | middle_name | last_name | suffix | address         | city    | state | zip | country |
| new    |           |            | charles    | in          | charge    |        | 777 chicago ave | chicago |       |     |         |
Then I should see "chicago" in the list of e911 lists
