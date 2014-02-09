require 'spec_helper'

describe GeosController do

  context 'not logged in' do
    it 'requires authentication' do
      get :index
      response.should be_redirect
    end
  end

  context "paginated" do
    login_user
    it_behaves_like "paginated"
  end

  context 'logged in' do
    login_user(:admin)

    describe "GET new" do
      it "should assign account_id" do
        get :new
        response.should be_success
        assigns(:geo).account_id.should_not be_nil
      end

      it "doesn't respond to json" do
        get :new, format: :json
        response.should_not be_success
      end
    end

    describe "POST create" do
      it "saves a geo model" do
        notification = create(:notification)
        post :create, geo:
          { geojson: %q[{"properties": "", "geometry": "", "type": ""}],
           notification_id: notification.id }
        response.should be_redirect
      end

      def new_valid_attributes
        { geo:
          { geojson: %q[{"properties": "", "geometry": "", "type": ""}],
           sse_channel: 'whatever' }}
      end

      it "can create a geo from the map_editor" do
        post :create, new_valid_attributes.merge(format: :json)
        response.should be_success
        assigns(:geo).should have_account
        assigns(:geo).should have_geojson
      end

      # TODO: post with json
      # TODO: rescue JSON.parse error
    end
  end
end
