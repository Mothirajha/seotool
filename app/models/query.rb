class Query < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :search_engine
end
