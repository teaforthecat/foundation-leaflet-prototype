class E911 < ActiveRecord::Base
  include ValidFileArgs
  belongs_to :account

  has_attached_file :subscriber_list
  validates :subscriber_list, valid_file_args
  validates_associated :account

  has_paper_trail

  after_save :count_subscribers


  # insert and update within the same transaction
  def count_subscribers
    number = open_spreadsheet(subscriber_list).count - 1 #headers
    self.update_column :subscriber_list_row_count, number
  end


  # Thanks Ryan!
  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv"  then Roo::CSV
    when ".ods"  then Roo::OpenOffice
    when ".xls"  then Roo::Excelc
    when ".xlsx" then Roo::Excelx
    else raise UnknownFileType.new("Unknown file type: #{file.original_filename}")
    end.send(:new, file.path)
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
  class UnknownFileType < Exception; end
end
