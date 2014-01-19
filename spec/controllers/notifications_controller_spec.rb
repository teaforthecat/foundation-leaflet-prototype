require 'spec_helper'
describe NotificationsController do

  # TODO: add security
  let( :valid_session) { {} }
  describe "new notification" do
    it "renders dcm_topics" do
      get :new, {}, valid_session
      @dcm_topics = assigns(:dcm_topics)
      @dcm_topics.first.should eq(["Ice Cream", "56789"])
    end
  end
end
