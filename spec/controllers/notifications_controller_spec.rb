require 'spec_helper'
describe NotificationsController do

  describe "new notification" do
    login_user(:admin)
    it "renders dcm_topics" do
      get :new, {}
      @dcm_topics = assigns(:dcm_topics)
      @dcm_topics.first.should eq(["Ice Cream", "56789"])
    end
  end

  describe "map editor" do
    it "renders an iframe body" do
      get :map_editor
debugger
      print page.body
      page.should have_selector "#map"
    end
  end
end
