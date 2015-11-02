json.array!(@jprofiles) do |jprofile|
  json.extract! jprofile, :id
  json.url jprofile_url(jprofile, format: :json)
end
