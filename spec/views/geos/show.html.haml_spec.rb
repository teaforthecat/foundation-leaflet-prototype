require 'spec_helper'

describe "geos/show" do
  before(:each) do
    @geo = assign(:geo, stub_model(Geo))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
