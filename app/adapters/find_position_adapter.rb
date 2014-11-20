class FindPositionAdapter

	class << self
	  def call_crawler_service crawler, domain, keyword, engine, query_id
	    result = {}
      scrap_obj = self.get_crawler_obj(crawler, domain, keyword, engine)
      result[query_id] = scrap_obj.get_keyword_position_on_100_result
	    result
	  end

	  def get_crawler_obj crawler, domain, keyword, engine
	    version = "v1"
	    require "#{Rails.root}/app/services/#{version}/#{crawler.downcase}"
	    object = Object.const_get "V1::#{crawler}::Scrap"
	    object.new(engine, domain, keyword)
	  end
	end

end