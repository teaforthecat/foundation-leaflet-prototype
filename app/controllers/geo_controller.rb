class GeoController < ApplicationController
  before_action :authenticate_user!
  layout false

  def new
    render :map
  end

  def show
    render :map
  end

  def create
    render :map
  end

end
