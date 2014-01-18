require 'spec_helper'

describe "notifications/edit" do
  before(:each) do
    @notification = assign(:notification, stub_model(Notification,
      :dcm_topic_id => 1,
      :dcm_account_code => "MyString"
    ))
  end

  it "renders the edit notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do
      assert_select "input#notification_dcm_topic_id[name=?]", "notification[dcm_topic_id]"
      assert_select "input#notification_dcm_account_code[name=?]", "notification[dcm_account_code]"
    end
  end
end
