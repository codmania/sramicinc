json.array!(@careers) do |career|
  json.extract! career, :id, :title, :description, :link
  json.url career_url(career, format: :json)
end
