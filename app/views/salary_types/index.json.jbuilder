json.array!(@salary_types) do |salary_type|
  json.extract! salary_type, :id
  json.url salary_type_url(salary_type, format: :json)
end
