require 'spec_helper'

describe "geos/index" do
  before(:each) do
    assign(:geos, [
      stub_model(Geo),
      stub_model(Geo)
    ])
  end

  it "renders a list of geos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
