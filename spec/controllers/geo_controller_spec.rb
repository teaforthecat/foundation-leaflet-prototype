require 'spec_helper'

describe GeoController do

  it 'requires authentication' do
    get :index
    response.should be_redirect
  end

  describe "map editor" do
    render_views
    login_user(:admin)

    it "renders an specified map" do
      get :show, id: SecureRandom.hex(8)
      response.body.should have_selector "#map"
    end

    it "accepts an json post of a map" do
      post :create, id: SecureRandom.hex(8), format: :json
      response.content_type.should eq('application/json')
    end

  end

end
