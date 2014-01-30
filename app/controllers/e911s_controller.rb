class E911sController < ApplicationController
  before_action :authenticate_user!
  before_action :set_e911, only: [:show, :edit, :update, :destroy]
  include Pagination

  def index
    @e911s = E911.where(account_id: current_user.account_id).paginate( pagination_args )
  end

  def new
    @e911 = E911.new
  end

  def create
    @e911 = E911.new(e911_params)
    @e911.account = current_user.account
    respond_to do |format|
      if @e911.save
        format.html { redirect_to e911s_path, notice: 'E911 was successfully created.' }
        format.json { render action: 'index', status: :created, location: e911s_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @e911.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_e911
    @e911 = E911.find(params[:id])
  end

  def e911_params
    attrs = :name, :subscriber_list
    params.require(:e911).permit(attrs)
  end

end
