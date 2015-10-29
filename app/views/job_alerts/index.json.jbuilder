json.array!(@job_alerts) do |job_alert|
  json.extract! job_alert, :id, :what, :where, :within, :user_id
  json.url job_alert_url(job_alert, format: :json)
end
