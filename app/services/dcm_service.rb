class DCMService
  include HTTParty
  base_uri 'http://dev.dcm.tops.gdi'

  def self.topics account_code
    get("/api/accounts/#{account_code}/topics", :headers => authorization)
  end

  def authorization
    {}
  end
end
