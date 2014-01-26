require 'spec_helper'

describe "geos/edit" do
  before(:each) do
    @geo = assign(:geo, stub_model(Geo))
  end

  it "renders the edit geo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", geo_path(@geo), "post" do
    end
  end
end
