class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_dcm_topics, only: [:new, :show, :edit]


  def index
    page, per_page = (params[:page].try(:to_i) || 1),
                     (params[:per_page].try(:to_i) || 20)
    @notifications = Notification.where(account_id: current_user.account_id).paginate( page: page, per_page: per_page)
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def edit
  end

  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @notification }
      else
        format.html { render action: 'new' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
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
      params.require(:notification).permit(:dcm_topic_id, :dcm_account_code)
    end
end
