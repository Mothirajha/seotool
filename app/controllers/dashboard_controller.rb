class DashboardController < ApplicationController
  before_action :authenticate_user!, except: :index
  require "#{Rails.root}/lib/modules/pre_crawler" 
  extend PreCrawler
  def index
    load_variables
  end

  def user_dashboard
    load_variables
  end

  private

  def get_crawler_obj engine, domain, keyword
    V1::Googler::Scrap.new engine, domain, keyword
  end

  def load_variables
    if params[:keyword]
      keywords = PreCrawler.get_keywords(params[:keyword])
      @result = []
      keywords.each do |keyword|      
        module_obj = get_crawler_obj(params[:engine], params[:domain], keyword)
        @result <<  module_obj.get_keyword_position_on_100_result
      end
      @search_engines = get_search_engine 
    else
      @search_engines = get_search_engine 
    end 
  end

  def get_search_engine
    SearchEngine.all
  end
end
