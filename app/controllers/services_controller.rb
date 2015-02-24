class ServicesController < ApplicationController
  include ApplicationHelper


  # GET /services/1
  # GET /services/1.json
  # GET /services/1.xml
  def show
    @service = Service.get_service params[:service_id]

    respond_to do |format|
      format.html
      format.xml { render xml: @service }
      format.json { render json: @service, callback: params['callback'] }
    end
  end


end
