class SearchEnginesController < ApplicationController
  before_action :set_search_engine, only: [:show, :edit, :update, :destroy]

  # GET /search_engines
  # GET /search_engines.json
  def index
    @search_engines = SearchEngine.all
  end

  # GET /search_engines/1
  # GET /search_engines/1.json
  def show
  end

  # GET /search_engines/new
  def new
    @search_engine = SearchEngine.new
  end

  # GET /search_engines/1/edit
  def edit
  end

  # POST /search_engines
  # POST /search_engines.json
  def create
    @search_engine = SearchEngine.new(search_engine_params)

    respond_to do |format|
      if @search_engine.save
        format.html { redirect_to @search_engine, notice: 'Search engine was successfully created.' }
        format.json { render :show, status: :created, location: @search_engine }
      else
        format.html { render :new }
        format.json { render json: @search_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_engines/1
  # PATCH/PUT /search_engines/1.json
  def update
    respond_to do |format|
      if @search_engine.update(search_engine_params)
        format.html { redirect_to @search_engine, notice: 'Search engine was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_engine }
      else
        format.html { render :edit }
        format.json { render json: @search_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_engines/1
  # DELETE /search_engines/1.json
  def destroy
    @search_engine.destroy
    respond_to do |format|
      format.html { redirect_to search_engines_url, notice: 'Search engine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_engine
      @search_engine = SearchEngine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_engine_params
      params.require(:search_engine).permit(:engine)
    end
end
