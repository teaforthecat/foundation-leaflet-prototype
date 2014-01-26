class GeosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_geo, only: [:show, :edit, :update, :destroy]
  include Pagination
  # GET /geos
  def index
    @geos = Geo.where(account_id: current_user.account_id).paginate(pagination_args)
  end

  # GET /geos/1
  def show
  end

  # GET /geos/new
  def new
    @geo = Geo.new
  end

  # GET /geos/1/edit
  def edit
  end

  # POST /geos
  def create
    @geo = Geo.new(geo_params)

    if @geo.save
      redirect_to @geo, notice: 'Geo was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /geos/1
  def update
    if @geo.update(geo_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo
      @geo = Geo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def geo_params
      params[:geo]
    end
end
