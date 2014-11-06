class DashboardController < ApplicationController

   def index
    if params[:keyword]
      module_obj = V1::Googler::Scrap.new params[:engine], params[:domain], params[:keyword]
      @result = module_obj.get_keyword_position_on_100_result
      @search_engines = SearchEngine.all
    else
      @search_engines = SearchEngine.all
    end
  end
end
