json.array!(@search_engines) do |search_engine|
  json.extract! search_engine, :id, :engine
  json.url search_engine_url(search_engine, format: :json)
end
