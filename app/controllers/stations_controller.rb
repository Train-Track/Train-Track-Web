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
      @stations =  Station.select("stations.*, #{distance_sql(lat,lng)} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").order("distance ASC")
    else
      @stations = Station.page(params[:page])
    end

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
    @station = Station.find_by crs: params[:crs]

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


end
