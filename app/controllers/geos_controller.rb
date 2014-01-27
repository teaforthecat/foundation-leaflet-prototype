class GeosController < ApplicationController
  before_action :authenticate_user!, except: [:sub, :pub]
  skip_before_action :verify_authenticity_token, only: [:pub,:sub]

  before_action :set_geo, only: [:show, :edit, :update, :destroy]

  include Pagination
  layout ->{ params[:iframe] ? 'geo_iframe' : 'application' }
  include ActionController::Live

  # GET /geos
  def index
    @geos = Geo.where(account_id: current_user.account_id).paginate(pagination_args)
  end

  # GET /geos/1
  def show
    @sse_channel = params[:sse_channel] or raise "No sse_channel in params"
  end

  # GET /geos/new
  def new
    @sse_channel = params[:sse_channel] or raise "No sse_channel in params"
    @geo = Geo.new
  end

  # GET /geos/1/edit
  def edit
    @sse_channel = params[:sse_channel] or raise "No sse_channel in params"
  end

  # POST /geos
  def create
    @geo = Geo.new(geo_params)
    @geo.account = current_user.account
    if @geo.save!
      redirect_to @geo, notice: 'Geo was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /geos/1
  def update
    if @geo.update!(geo_params)
      redirect_to @geo, notice: 'Geo was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /geos/1
  def destroy
    @geo.destroy
    redirect_to geos_url, notice: 'Geo was successfully destroyed.'
  end

  def pub
    logger.info "pub: #{params[:id]} = #{params[:geo]}"
    Rails.cache.write(params[:id], JSON.dump(params[:geo].to_hash))
    render json: 'ok'
  end

  #TODO: move to redis, this requires one server or an external memcache server
  def sub
    logger.info "sub: " + Rails.cache.read(params[:id]).to_s
    if (cache_value = Rails.cache.read(params[:id])).nil?
      raise ActiveRecord::RecordNotFound # cache should be set
    end
    begin
      response.headers["Content-Type"] = "text/event-stream"
      10.times do
        cache_value = Rails.cache.read(params[:id]) #tmp
        response.stream.write(  sse( JSON.parse(cache_value), {event: 'geo', id: SecureRandom.hex(8) } ) )
        sleep(1)
      end
    rescue IOError
      logger.info "Stream closed"
    ensure
      logger.info "ensure closed"
      response.stream.close
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_geo
    @geo = Geo.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def geo_params
    params.require(:geo).permit(:geo_json)
  end

  # http://ngauthier.com/2013/02/rails-4-sse-notify-listen.html
  def sse(object, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  end

end
