class Campaign < ActiveRecord::Base
  belongs_to :domain
  has_many :queries
end
