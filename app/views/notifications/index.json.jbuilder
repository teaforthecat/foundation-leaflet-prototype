json.array!(@notifications) do |notification|
  json.extract! notification, :id, :dcm_topic_id, :dcm_account_code
  json.url notification_url(notification, format: :json)
end
