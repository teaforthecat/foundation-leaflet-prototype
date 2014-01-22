require "spec_helper"

describe NotificationsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/notifications").to route_to("notifications#index")
    end

    it "routes to #new" do
      expect(:get => "/notifications/new").to route_to("notifications#new")
    end

    it "routes to #show" do
      expect(:get => "/notifications/1").to route_to("notifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/notifications/1/edit").to route_to("notifications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/notifications").to route_to("notifications#create")
    end

    it "routes to #update" do
      expect(:put => "/notifications/1").to route_to("notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/notifications/1").to route_to("notifications#destroy", :id => "1")
    end

    it "routes to #map_editor" do
      expect(:get => "/map_editor").to route_to("notifications#map_editor")
      expect(map_editor_path).to eql("/map_editor")
    end
  end
end
