class Keyword < ActiveRecord::Base
  belongs_to :domain
  belongs_to :search_engine
end
