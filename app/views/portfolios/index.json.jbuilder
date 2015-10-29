json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :name, :url, :logo
  json.url portfolio_url(portfolio, format: :json)
end
