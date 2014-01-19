Given(/^I have an account with a dcm account code: "(.*?)"$/) do |code|
  # account = create_stubbed( :dcm_account, code: code )
  # DCM::Account.stub(:find).and_return( account )
end
#TODO: maybe work these out for real, accessing dcm api an recording it with vcr
Given(/^I have a dcm account with a topic "(.*?)"$/) do |name|
  # topic = create_stubbed( :dcm_topic, name: name )
  # DCM::Topic.stub(:find).and_return( topic )
end

When(/^I create a new notification$/) do
  visit new_notification_path
  find('form.new_notification').should be_visible
end

When(/^I select "(.*?)" from "(.*?)"$/) do |option, label|
  select option, from: label
end

Then(/^I should be able to schedule the notification$/) do
  find_button('Schedule').should be_visible
end

Then(/^I should be able to send the notification$/) do
  find_button('Send').should be_visible
end

Given(/^I have an account without a dcm account$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
