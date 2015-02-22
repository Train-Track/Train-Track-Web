class StaticPagesController < ApplicationController

  # GET /
  # GET /.json
  # GET /.xml
  def index
    @journeys = []

    respond_to do |format|
      format.html
      format.xml { render xml: @journeys }
      format.json { render json: @journeys, callback: params['callback'] }
    end
  end

end
