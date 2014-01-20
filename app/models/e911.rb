require 'csv'
class E911 < ActiveRecord::Base

  has_attached_file :subscriber_list
  validates :subscriber_list, :attachment_presence => true
  has_paper_trail

  after_save :count_subscribers

  # insert and update within the same transaction
  def count_subscribers
    number = CSV.read(subscriber_list.path).count - 1 #headers
    self.update_column :subscriber_list_row_count, number
  end
      # expected format of the spreadsheet is
      # action -- [new,update,delete]
      # record id -- the record's crypto hash or nil
      # salutation
      # first name
      # middle name
      # last name
      # suffix
      # address line 1
      # address line 2
      # city
      # state
      # zip
      # country
      # ** now there will be n-of these pairs
      # method type [email,sms,voice]
      # method value

end
