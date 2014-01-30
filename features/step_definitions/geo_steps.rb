When(/^I go to create a map$/) do
  visit new_geo_path
  find('form.new_geo').should be_visible
end

When(/^I name it "(.*?)"$/) do |name|
  fill_in "Name", with: name
end

When(/^I draw a square on the map$/) do
  #pass
end

When(/^I save it$/) do
  click "Save"
end

Then(/^I should see "(.*?)" in the list of geo maps$/) do |name|
  page.should have_content(name)
end
