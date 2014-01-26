class Geo < ActiveRecord::Base
  # geojson: :properties, :type, :geometry{:type,:coordinates}
  # other: :search_value, :map_bounds
  serialize :geojson, JSON
  belongs_to :notification
  belongs_to :account
  validates_presence_of :notification
  validates_presence_of :account


  # Note: serializing geojson avoids "Invalid single-table inheritance type: Feature" from 'type' key in geojson spec

end
