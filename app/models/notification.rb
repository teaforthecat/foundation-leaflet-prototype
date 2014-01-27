class Notification < ActiveRecord::Base

  belongs_to :account
  has_and_belongs_to_many :e911s
  has_one :geo


  before_save :join_geo, if: :new_record?

  def join_geo
    self.geo ||= Geo.find(sse_channel: self.sse_channel)
  end

end
