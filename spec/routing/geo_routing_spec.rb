require "spec_helper"

describe GeoController do
  describe "routing" do

    it "routes to #map_editor" do
      expect(:get => "/geo").to route_to("geo#index")
      expect(:get => "/geo/new").to route_to("geo#new")
      expect(:get => "/geo/abc123").to route_to("geo#show", id: 'abc123')
      expect(:post => "/geo").to route_to("geo#create")
      expect(:update => "/geo").not_to be_routable

    end
  end
end
