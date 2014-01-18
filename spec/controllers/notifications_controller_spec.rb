require 'spec_helper'
describe NotificationsController do
  let(:valid_attributes) { { "dcm_topic_id" => "1" } }
  let(:valid_session) { {user_id: 1} }

  before :each do
    stub_dcm
  end

  describe "GET index" do
    it "assigns all notifications as @notifications" do
      notification = create(:notification, valid_attributes)
      get :index, {}, valid_session
      expect(assigns(:notifications)).to eq([notification])
    end
  end

  describe "GET show" do
    it "assigns the requested notification as @notification" do
      notification = Notification.create! valid_attributes
      get :show, {:id => notification.to_param}, valid_session
      expect(assigns(:notification)).to eq(notification)
    end
  end

  describe "GET new" do
    it "assigns a new notification as @notification" do
      get :new, {}, valid_session
      expect(assigns(:notification)).to be_a_new(Notification)
    end
  end

  describe "GET edit" do
    it "assigns the requested notification as @notification" do
      notification = Notification.create! valid_attributes
      get :edit, {:id => notification.to_param}, valid_session
      expect(assigns(:notification)).to eq(notification)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Notification" do
        expect {
          post :create, {:notification => valid_attributes}, valid_session
        }.to change(Notification, :count).by(1)
      end

      it "assigns a newly created notification as @notification" do
        post :create, {:notification => valid_attributes}, valid_session
        expect(assigns(:notification)).to be_a(Notification)
        expect(assigns(:notification)).to be_persisted
      end

      it "redirects to the created notification" do
        post :create, {:notification => valid_attributes}, valid_session
        expect(response).to redirect_to(Notification.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved notification as @notification" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Notification).to receive(:save).and_return(false)
        post :create, {:notification => { "dcm_topic_id" => "invalid value" }}, valid_session
        expect(assigns(:notification)).to be_a_new(Notification)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Notification).to receive(:save).and_return(false)
        post :create, {:notification => { "dcm_topic_id" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested notification" do
        notification = Notification.create! valid_attributes
        # Assuming there are no other notifications in the database, this
        # specifies that the Notification created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Notification).to receive(:update).with({ "dcm_topic_id" => "1" })
        put :update, {:id => notification.to_param, :notification => { "dcm_topic_id" => "1" }}, valid_session
      end

      it "assigns the requested notification as @notification" do
        notification = Notification.create! valid_attributes
        put :update, {:id => notification.to_param, :notification => valid_attributes}, valid_session
        expect(assigns(:notification)).to eq(notification)
      end

      it "redirects to the notification" do
        notification = Notification.create! valid_attributes
        put :update, {:id => notification.to_param, :notification => valid_attributes}, valid_session
        expect(response).to redirect_to(notification)
      end
    end

    describe "with invalid params" do
      it "assigns the notification as @notification" do
        notification = Notification.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Notification).to receive(:save).and_return(false)
        put :update, {:id => notification.to_param, :notification => { "dcm_topic_id" => "invalid value" }}, valid_session
        expect(assigns(:notification)).to eq(notification)
      end

      it "re-renders the 'edit' template" do
        notification = Notification.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Notification).to receive(:save).and_return(false)
        put :update, {:id => notification.to_param, :notification => { "dcm_topic_id" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested notification" do
      notification = Notification.create! valid_attributes
      expect {
        delete :destroy, {:id => notification.to_param}, valid_session
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to the notifications list" do
      notification = Notification.create! valid_attributes
      delete :destroy, {:id => notification.to_param}, valid_session
      expect(response).to redirect_to(notifications_url)
    end
  end

end
