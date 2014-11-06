json.array!(@keywords) do |keyword|
  json.extract! keyword, :id, :domain_id, :search_engine_id, :word
  json.url keyword_url(keyword, format: :json)
end
