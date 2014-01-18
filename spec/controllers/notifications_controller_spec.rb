require 'spec_helper'
describe NotificationsController do

  # TODO: add security
  let( :valid_session) { {} }
  describe "new notification" do
    it "renders dcm_topics" do
      get :new, {}, valid_session
      expect(assigns(:dcm_topics)).to eq([])
    end
  end
end
