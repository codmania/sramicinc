json.array!(@watch_lists) do |watch_list|
  json.extract! watch_list, :id, :job_id, :jobseeker_id
  json.url watch_list_url(watch_list, format: :json)
end
