class Geo < ActiveRecord::Base
  # geojson: :properties, :type, :geometry{:type,:coordinates}
  # other: :search_value, :map_bounds
  serialize :geojson, JSON
  has_many :notifications
  belongs_to :account
  validates_presence_of :account
  validates_presence_of :geojson
  validate :valid_geojson?

  # Note: serializing geojson avoids "Invalid single-table inheritance type: Feature" from 'type' key in geojson spec


  def valid_geojson?
   geojson.present? &&  %W[ type properties geometry ].
      all?{|k| geojson.member?(k)}
  end
end
