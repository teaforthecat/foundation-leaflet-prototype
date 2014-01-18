require 'spec_helper'

describe "notifications/new" do
  before(:each) do
    assign(:notification, stub_model(Notification,
      :dcm_topic_id => 1,
      :dcm_account_code => "MyString"
    ).as_new_record)
  end

  it "renders new notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notifications_path, "post" do
      assert_select "input#notification_dcm_topic_id[name=?]", "notification[dcm_topic_id]"
      assert_select "input#notification_dcm_account_code[name=?]", "notification[dcm_account_code]"
    end
  end
end
