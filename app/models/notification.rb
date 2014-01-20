class Notification < ActiveRecord::Base

  has_and_belongs_to_many :e911s
end
