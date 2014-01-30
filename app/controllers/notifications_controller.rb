class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_dcm_topics, only: [:new, :show, :edit]
  include Pagination

  def index
    @notifications = Notification.where(account_id: current_user.account_id).paginate( pagination_args )
  end

  def show
  end

  def new
    #temporary pointer to join objects because geo is saved from an an iframe
    @sse_channel = SecureRandom.hex(8)
    Rails.cache.write(@sse_channel, "{}")
    @notification = Notification.new(sse_channel: @sse_channel)
    @geo = @notification.build_geo(sse_channel: @sse_channel)
  end

  def edit
    @sse_channel = SecureRandom.hex(8)
    Rails.cache.write(@sse_channel, "{}")
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.account = current_user.account
    @geo = @notification.build_geo geo_params.fetch("geo")
    @geo.account = current_user.account
    respond_to do |format|
      if @notification.save! && @geo.save!
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @notification }
      else
        format.html { render action: 'new' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @notification = Notification.new(notification_params)
    @geo = @notification.build_geo geo_params.fetch("geo")
    @geo.account = current_user.account
    respond_to do |format|
      if @notification.update!(notification_params) && @geo.save!
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def set_dcm_topics
      account_code = current_user.account.dcm_account_code
      resp = DCMService.get "http://test.dcm.tops.gdi/api/accounts/#{account_code}/topics"
      @dcm_topics = resp.parsed_response.collect{|topic| prepare_topic(topic) }
    end

    def prepare_topic topic
      [topic.fetch("name"), topic.fetch("id")]
    end

    def current_account_code
      "oauth"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require("notification").
        permit( :message, :dcm_topic_id)

    end

    def geo_params
      params.require(:notification).permit({geo: :geojson})
    end
end
