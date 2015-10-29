json.array!(@talent_alerts) do |talent_alert|
  json.extract! talent_alert, :id, :what, :where, :within, :user_id
  json.url talent_alert_url(talent_alert, format: :json)
end
