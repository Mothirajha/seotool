module PreCrawler

  CRAWLER_CONSTANTS = {
    "google" => "Googler",
    "yahoo" => "Yahler",
    "bing" => "Bingler"
  }

  def self.get_keywords keywords
    keywords.split(',').uniq
  end

  def self.select_crawler search_engine_id
    engine = SearchEngine.find(search_engine_id).engine
    search_engine = PreCrawler.get_exact_domain(engine)
    [CRAWLER_CONSTANTS["#{search_engine}"], engine]
  end

  def self.get_domain campaign_id
    domain_name = Campaign.find(campaign_id).domain.name
  end

  def self.get_exact_domain url
    Domainatrix.parse(url).domain
  end

  def self.get_crawler_obj crawler, domain, keyword, engine
    version = "v1"
    require "#{Rails.root}/app/services/#{version}/#{crawler.downcase}"
    object = Object.const_get "V1::#{crawler}::Scrap"
    object.new(engine, domain, keyword)
  end

  def self.get_positions crawler, domain, queries, engine
    result = {}
    queries.each do |query|
      keyword = query.keyword
      scrap_obj = PreCrawler.get_crawler_obj(crawler, domain, keyword, engine)
      result[query.id] = scrap_obj.get_keyword_position_on_100_result
    end
    result
  end


end
