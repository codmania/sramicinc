json.array!(@city_lists) do |city_list|
  json.extract! city_list, :id
  json.url city_list_url(city_list, format: :json)
end
