require 'spec_helper'

describe GeosController do

  it_behaves_like "paginated"

  it 'requires authentication' do
    get :index
    response.should be_redirect
  end

  describe "map editor" do

    # render_views
    # login_user(:admin)
    # it "renders an specified map" do
    #   geo = build_stubbed(:geo)
    #   expect(Geo).to receive(:find).and_return(geo)
    #   get :show, id: geo.id
    #   response.body.should have_selector "#map"
    #   assigns(:geo).should_not be_nil
    # end

    # it "accepts an json post of a map" do
    #   post :create, id: 3456, format: :json
    #   response.content_type.should eq('application/json')
    # end

    # it "accepts geojson as a post body" do
    #   post :create, id: 3456, format: :json
    #   response.should be_success
    # end
  end

end
