json.array!(@certifications) do |certification|
  json.extract! certification, :id, :name, :institution, :received, :expired
  json.url certification_url(certification, format: :json)
end
