class Query < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :search_engine
  has_one :query_result
  validates :keyword, :uniqueness => {scope: [:campaign_id, :search_engine_id]}, presence: true
end
