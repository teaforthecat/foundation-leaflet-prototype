class DCM::Topic
  attr_accessor :id, :name

  def self.where args
    account_code = args.fetch(:account_code)
    # TODO: use DCM API
  end
end
