class GeosController < ApplicationController
  before_action :authenticate_user!
  before_action :require_account!
  before_action :set_geo, only: [:show, :edit, :update, :destroy]

  include Pagination
  # layout ->{ params[:iframe] ? 'geo_iframe' : 'application' }
  layout 'geo_iframe'
  # must wrap routes: https://github.com/plataformatec/devise/issues/2332
  # if you want to use Live
  # include ActionController::Live # problem with authenticate_user!

  def index
    @geos = Geo.where(account_id: current_user.account_id).paginate(pagination_args)
  end

  def show
    @sse_channel = params[:sse_channel] or raise "No sse_channel in params"
  end

  def new
    @sse_channel = params[:sse_channel] #or raise "No sse_channel in params"
    respond_to do |f|
      f.html {
        @geo = Geo.new(account_id: current_user.account_id)
      }
      f.json { head :bad_request }
    end
  end

  def edit
    # @sse_channel = params[:sse_channel] or raise "No sse_channel in params"
  end

  def create
    @geo = Geo.new(geo_params)
    @geo.geojson = JSON.parse(geo_params["geojson"])
    @geo.account = current_user.account
    if @geo.save!
      redirect_to @geo, notice: 'Geo was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @geo.update!(geo_params)
      redirect_to @geo, notice: 'Geo was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @geo.destroy
    redirect_to geos_url, notice: 'Geo was successfully destroyed.'
  end


  private

  def set_geo
    @geo = Geo.find(params[:id])
  end

  def geo_params
    params.require(:geo).permit(:geojson, :notification_id)
  end

end
