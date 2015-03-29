class Tube::StaticPagesController < ApplicationController
  include ApplicationHelper


  # GET /tube
  # GET /tube.json
  # GET /tube.xml
  def index
    @lines = Tube::Line.get_status
    @q = params['q']

    if params['lat'] and params['lng']
      lat = params['lat'].to_f
      lng = params['lng'].to_f
      @stations = Station.unscoped.underground.select("stations.*, #{distance_sql(lat,lng)} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").order("distance ASC").limit(1)
    elsif @q && !@q.empty?
      @stations = Station.underground.where("crs LIKE ? OR name LIKE ?", @q, "#{@q}%").page(params[:page])
    else
      @stations = Station.underground.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.xml { render xml: @stations }
      format.json { render json: @stations, callback: params['callback'] }
    end
  end


  # GET /tube/ABC
  # GET /tube/ABC.json
  # GET /tube/ABC.xml
  def show
    @station = Station.find_by! underground_code: params[:underground_code]
    @trains = []

    respond_to do |format|
      format.html
      format.xml { render xml: @station }
      format.json { render json: @station, callback: params['callback'] }
    end
  end


end
