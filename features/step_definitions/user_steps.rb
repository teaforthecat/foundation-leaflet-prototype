Given(/^I am new to the site$/) do
  visit root_path
end

When(/^I register with a valid email address and password$/) do
  visit new_user_registration_path
  fill_in :user_email, with: "valid@test.com"
  fill_in :user_password, with: "8digits8"
  fill_in :user_password_confirmation, with: "8digits8"
  within "form.new_user" do
    find('[name=commit]').click #click_button "Sign up"
  end
end

Then(/^I should be logged in$/) do
  find_link('logout').visible?
end