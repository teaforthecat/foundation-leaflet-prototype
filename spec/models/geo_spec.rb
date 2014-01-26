require 'spec_helper'

describe Geo do
  it "should store geojson coordinates" do
    geo = create(:geo)
    expect(geo.geojson).to be_kind_of(Hash)
    geo.geojson["geometry"]["coordinates"].should be_kind_of(Array)
  end
end
