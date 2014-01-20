require 'spec_helper'

describe "Notifications" do
  describe "notifications index" do
    it "redirects if not logged in" do
      get notifications_path
      expect(response.status).to be(302)
    end
  end
end
