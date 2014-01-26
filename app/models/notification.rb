class Notification < ActiveRecord::Base

  belongs_to :account
  has_and_belongs_to_many :e911s
end
