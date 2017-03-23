class CommunesController < ApplicationController
  def index
    respond_to do |format|
      format.json do 
        head :ok
      end
      format.html do
        head :not_acceptable
      end
    end
  end
  def create
    head :forbidden
  end
  def show
    if(Commune.find_by code_insee: params[:id])
      head :ok
    else
      head :not_found
    end
  end
  def update
    if(@commune = Commune.find_by code_insee: params[:id])
      if(params[:commune]!=nil)
        @commune.update_attributes(params[:commune].permit(:name, :code_insee))
        head :no_content
      else
        head :bad_request
      end
    else
      head :not_found
    end
  end
end
