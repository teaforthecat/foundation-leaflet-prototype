require 'spec_helper'

describe E911sController do

  describe ":index" do

    it "paginates using params[:per_page]" do
      create_list(:e911, 3)
      get :index, page: 1, per_page: 2
      expect(assigns(:e911s).size).to eql(2)
    end

  end

end
