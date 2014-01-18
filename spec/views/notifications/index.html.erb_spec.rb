require 'spec_helper'

describe "notifications/index" do
  before(:each) do
    assign(:notifications, [
      stub_model(Notification,
        :dcm_topic_id => 1,
        :dcm_account_code => "Dcm Account Code"
      ),
      stub_model(Notification,
        :dcm_topic_id => 1,
        :dcm_account_code => "Dcm Account Code"
      )
    ])
  end

  it "renders a list of notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Dcm Account Code".to_s, :count => 2
  end
end
