module PreCrawler

  def self.get_keywords(keywords)
    keywords.split(',')
  end

#  def load_crawler_module
#    V1::Googler::Scrap.new params[:engine], params[:domain], params[:keyword] 
#  end
end
