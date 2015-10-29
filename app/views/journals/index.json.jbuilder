json.array!(@journals) do |journal|
  json.extract! journal, :id, :name, :date, :reference
  json.url journal_url(journal, format: :json)
end
