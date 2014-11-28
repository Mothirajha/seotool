class Query < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :search_engine
  has_one :query_result
  validates :keyword, :uniqueness => {scope: [:campaign_id, :search_engine_id]}, presence: true

  def self.to_csv(options={})
    CSV.generate(options) do |csv|
      csv << ["Domain", "Campaign",  "Keyword", "Engine", "Position", "Ranking page Url", "Previous Positon", "Last Updated"]
      all.each do |query|
        csv << [query.campaign.domain.name, query.campaign.name, query.keyword, query.search_engine.engine, query.query_result.position, query.query_result.url, query.query_result.previous_position, query.query_result.last_updated.strftime("%d-%b-%Y")]
      end
    end

  end
end    
