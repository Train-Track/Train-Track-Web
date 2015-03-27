class Tube::StaticPagesController < ApplicationController

  # GET /tubes
  # GET /tubes.json
  # GET /tubes.xml
  def index

    @lines = Tube::Line.get_status

    respond_to do |format|
      format.html
      format.xml { render xml: @lines }
      format.json { render json: @lines, callback: params['callback'] }
    end
  end

end
