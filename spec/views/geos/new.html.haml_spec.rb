require 'spec_helper'

describe "geos/new" do
  before(:each) do
    assign(:geo, stub_model(Geo).as_new_record)
  end

  it "renders new geo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", geos_path, "post" do
    end
  end
end
