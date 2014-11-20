class QueriesController < ApplicationController

  require "#{Rails.root}/lib/modules/pre_crawler"
  extend PreCrawler

  before_action :set_query, only: [:show, :edit, :update, :destroy]

  # GET /queries
  # GET /queries.json
  def index
    @queries = Query.all
    respond_to do |format|
      if @queries
        format.html
        format.csv {send_data @queries.to_csv}
        format.xls { send_data @queries.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
  end

  # GET /queries/new
  def new
    @query = Query.new
  end

  # GET /queries/1/edit
  def edit
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)

    respond_to do |format|
      if @query.save
        format.html { redirect_to @query, notice: 'Query was successfully created.' }
        format.json { render :show, status: :created, location: @query }
      else
        format.html { render :new }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queries/1
  # PATCH/PUT /queries/1.json
  def update
    respond_to do |format|
      if @query.update(query_params)
        format.html { redirect_to @query, notice: 'Query was successfully updated.' }
        format.json { render :show, status: :ok, location: @query }
      else
        format.html { render :edit }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def add_or_update

    params = query_params
    crawler_engine = PreCrawler.select_crawler(params[:search_engine_id])
    crawler = crawler_engine[0]
    engine = crawler_engine[1]
    keywords = PreCrawler.get_keywords(params[:keyword])
    domain = PreCrawler.get_domain(params[:campaign_id])
    query_ids = get_query(keywords, params[:campaign_id], params[:search_engine_id])
    #FindPositionAdapter(crawler, domain, query_ids, engine)
    FindPosition.break_keywords(crawler, domain, query_ids, engine)
    redirect_to authenticated_root_path
  end
  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:keyword, :campaign_id, :search_engine_id)
    end


    def get_query keywords, campaign_id, search_engine_id
      query_ids = []
      keywords.each do |keyword|
        query_ids << Query.find_or_create_by(keyword: keyword.downcase.strip, campaign_id: campaign_id, search_engine_id: search_engine_id ).id
      end
      query_ids
    end


    def get_search_engine search_engine_id
      SearchEngine.find search_engine_id
    end
end
