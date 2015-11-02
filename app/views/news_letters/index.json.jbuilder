json.array!(@news_letters) do |news_letter|
  json.extract! news_letter, :id, :title, :name, :email, :active
  json.url news_letter_url(news_letter, format: :json)
end
