class AjaxJsonController < ApplicationController
  def get_campaigns
    @campaigns = Campaign.where(domain_id: params[:domain_id]).order(:name)
    respond_to do |format|
      format.html 
      format.json { render json: @campaigns  }
    end
  end
end
