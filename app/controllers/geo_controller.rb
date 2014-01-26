class GeoController < ApplicationController
  before_action :authenticate_user!
  layout false
  respond_to :json, :html

  def new
    @geo = Geo.new
    render :map
  end

  def show
    @geo = Geo.find(params[:id])
    render :map
  end

  def create
    @geo = Geo.new(params[:geo])
    @geo.save!
    render :map
  end

  def update
    @geo = Geo.find(params[:id])
    @geo.update_attributes!(params[:geo])
    render :map
  end

  def delete
    @geo = Geo.find(params[:id])
    @geo.delete!
    render :map
  end

end
