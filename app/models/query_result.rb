class QueryResult < ActiveRecord::Base
  belongs_to :query

  def self.insert_or_update_data(result)
    result.each do |query_id, value|
      if query_result = self.find_by(query_id: query_id)
        query_result.update_attributes(previous_position: query_result.position, last_updated: query_result.updated_at, position: value["position"], url: value["url"])
      else
        self.create(query_id: query_id, position: value["position"], url: value["url"], last_updated: Time.now)
      end
    end
  end
end
