module ValidFileArgs
  extend ActiveSupport::Concern
  module ClassMethods
    def valid_file_args
      { attachment_presence: true,
        attachment_content_type: {
          content_type: [
                         "text/csv",
                         "application/vnd.oasis.opendocument.spreadsheet",
                         "application/x-excel",
                         "application/excel",
                         "application/vnd.ms-excel",
                         "application/x-excel",
                         "application/x-msexcel"]}}
    end
  end
end
