class StationsController < ApplicationController
  include ApplicationHelper


  # GET /stations
  # GET /stations.json
  # GET /stations.xml
  def index
    @q = params['q']

    if params['lat'] and params['lng']
      lat = params['lat'].to_f
      lng = params['lng'].to_f
      @stations = Station.unscoped.select("stations.*, #{distance_sql(lat,lng)} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").order("distance ASC").limit(1)
    elsif @q && !@q.empty?
      @stations = Station.where("crs LIKE ? OR name LIKE ?", @q, "#{@q}%").page(params[:page])
    else
      @stations = Station.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.xml { render xml: @stations }
      format.json { render json: @stations, callback: params['callback'] }
    end
  end


  # GET /stations/all
  # GET /stations/all.json
  # GET /stations/all.xml
  def all
    @stations = Station.all

    respond_to do |format|
      format.html
      format.xml { render xml: @stations }
      format.json { render json: @stations, callback: params['callback'] }
    end
  end


  # GET /stations/1
  # GET /stations/1.json
  # GET /stations/1.xml
  def show
    @station = Station.find_by! crs: params[:crs]

    @og = {
        "og:title" => @location,
        "og:type" => "train-track:station",
        "og:url" => request.original_url,
        "og:image" => "https://maps.google.com/maps?ll=#{@station.lat},#{@station.lng}&amp;z=15&amp;output=embed",
        "og:site_name" => "dyl.anjon.es",
        "fb:app_id" => "272514462916508",
        "train-track:crs" => @station.crs
      }

    respond_to do |format|
      format.html
      format.xml { render xml: @station }
      format.json { render json: @station, callback: params['callback'] }
    end
  end


  # GET /stations/1/departures
  # GET /stations/1/departures.json
  # GET /stations/1/departures.xml
  def departures
    @station = Station.find_by! crs: params[:crs]
    @departure_board = @station.get_departure_board

    respond_to do |format|
      format.html
      format.xml { render xml: @departure_board }
      format.json { render json: @departure_board, callback: params['callback'] }
    end
  end


  # GET /stations/1/arrivals
  # GET /stations/1/arrivals.json
  # GET /stations/1/arrivals.xml
  def arrivals
    @station = Station.find_by! crs: params[:crs]
    @arrival_board = @station.get_arrival_board

    respond_to do |format|
      format.html
      format.xml { render xml: @arrival_board }
      format.json { render json: @arrival_board, callback: params['callback'] }
    end
  end

end
