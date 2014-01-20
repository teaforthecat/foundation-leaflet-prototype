Feature: Reverse 911
As an account admin
In order to contact as many people as possible in the case of an emergency
I want to upload lists of subscriber data

@file-upload
Scenario: Uploading an e911 list
Given I am logged in as an account admin
When I upload a file named "chicago.csv" that contains:
| action | record_id | salutation | first_name | middle_name | last_name | suffix | address         | city    | state | zip | country |
| new    |           |            | charles    | in          | charge    |        | 777 chicago ave | chicago |       |     |         |
Then I should see "chicago" in the list of e911 lists
