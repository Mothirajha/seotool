class SearchEnginesController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]


  def index
    @search_engines = SearchEngine.all
  end
  def new
    @search_engine = SearchEngine.new 
  end

  def create
    @search_engine = SearchEngine.new(search_engine_params)

    respond_to do |format|
      if @search_engine.save
        format.html { redirect_to @search_engine, notice: 'Search Engine was successfully created.' }
        format.json { render :show, status: :created, location: @search_engine }
      else
        format.html { render :new }
        format.json { render json: @search_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

    def update
    respond_to do |format|
      if @search_engine.update(search_engine_params)
        format.html { redirect_to @search_engine, notice: 'SearchEngine was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_engine }
      else
        format.html { render :edit }
        format.json { render json: @search_engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @search_engine.destroy
    respond_to do |format|
      format.html { redirect_to search_engines_url, notice: 'SearchEngine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_domain
    @search_engine = SearchEngine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def search_engine_params
    params.require(:search_engine).permit(:engine)
  end
end
