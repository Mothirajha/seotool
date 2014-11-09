json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :domain_id
  json.url campaign_url(campaign, format: :json)
end
