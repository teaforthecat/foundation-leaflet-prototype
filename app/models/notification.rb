class Notification < ActiveRecord::Base

  belongs_to :account
  belongs_to :geo
  has_and_belongs_to_many :e911s


  before_save :join_geo, if: :new_record?

  def join_geo
    self.geo ||= Geo.where(sse_channel: self.sse_channel).first
  end

end
