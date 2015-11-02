json.array!(@country_lists) do |country_list|
  json.extract! country_list, :id
  json.url country_list_url(country_list, format: :json)
end
