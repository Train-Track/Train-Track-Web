class Tube::StaticPagesController < ApplicationController
  include ApplicationHelper
  include UndergroundApiHelper


  # GET /tube
  # GET /tube.json
  # GET /tube.xml
  def index
    @lines = Tube::Line.get_status
    @weekend = Tube::Line.get_weekend
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


end
