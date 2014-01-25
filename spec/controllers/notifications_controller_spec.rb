require 'spec_helper'
describe NotificationsController do

  it 'requires authentication' do
    get :index
    response.should be_redirect
  end

  describe "new notification" do
    login_user(:admin)
    it "renders dcm_topics" do
      get :new, {}
      @dcm_topics = assigns(:dcm_topics)
      @dcm_topics.first.should eq(["Ice Cream", "56789"])
    end
  end

end
