class Tube::StaticPagesController < ApplicationController

  # GET /tube
  # GET /tube.json
  # GET /tube.xml
  def index
    @lines = Tube::Line.get_status
    @stations = Station.where(underground: true)

    respond_to do |format|
      format.html
      format.xml { render xml: @lines }
      format.json { render json: @lines, callback: params['callback'] }
    end
  end


  # GET /tube/ABC
  # GET /tube/ABC.json
  # GET /tube/ABC.xml
  def show
    @station = Station.where(underground_code: params[:underground_code]).first
    @trains = []

    respond_to do |format|
      format.html
      format.xml { render xml: @station }
      format.json { render json: @station, callback: params['callback'] }
    end
  end

end
