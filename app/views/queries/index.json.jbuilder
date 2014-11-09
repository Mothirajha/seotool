json.array!(@queries) do |query|
  json.extract! query, :id, :keyword, :campaign_id, :search_engine_id
  json.url query_url(query, format: :json)
end
