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

end