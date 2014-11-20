class FindPosition
  include Sidekiq::Worker
  # sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def self.get_position(crawler, domain, keyword, engine, query_id)
		result = FindPositionAdapter.call_crawler_service(crawler, domain, keyword, engine, query_id)
		QueryResult.insert_or_update_data(result)
  end

  def self.break_keywords(crawler, domain, query_ids, engine)
  	query_ids.each do |query_id|
  		query = Query.find query_id
  		keyword = query.keyword
  		FindPosition.delay.get_position(crawler, domain, keyword, engine, query_id)
  	end
  end

end