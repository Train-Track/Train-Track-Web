require 'will_paginate/array'
class JourneysController < ApplicationController
  before_filter :authenticate_user!, except: [:show]


  # GET /journeys
  # GET /journeys.json
  # GET /journeys.xml
  def index
    @journeys = Journey.where(user_id: current_user.id).page(params[:page])
    @journey = Journey.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journeys, callback: params[:callback] }
      format.xml { render xml: @journeys }
    end
  end


  # GET /journey/1
  # GET /journey/1.json
  # GET /journey/1.xml
  def show
    @journey = Journey.find(params[:id])

    @og = {
      "og:title" => @journey,
      "og:type" => "train-track:train_journey",
      "og:url" => request.original_url,
      "og:image" => @journey.google_map_image,
      "og:site_name" => "Train Track",
      "fb:app_id" => "272514462916508",
      "train-track:origin_station" => @journey.origin.url,
      "train-track:destination_station" => @journey.destination.url
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journey, methods: [:origin, :destination, :journey_legs], callback: params[:callback] }
      format.xml { render xml: @journey, methods: [:origin, :destination, :journey_legs] }
    end
  end


  # GET /trains/journey/1/edit
  def edit
    @journey = Journey.find(params[:id])
    render_403 and return if @journey.user_id != current_user.id
  end


  # POST /trains/journey
  # POST /trains/journey.json
  def create
    @journey = Trains::Journey.new(user_id: current_user.id)

    respond_to do |format|
      if @journey.save
        format.html { redirect_to new_trains_journey_journey_leg_path(@journey), notice: 'Journey was successfully created.' }
        format.json { render json: @journey, status: :created, location: new_trains_journey_journey_leg_path(@journey) }
        format.xml { render xml: @journey, status: :created, location: new_trains_journey_journey_leg_path(@journey) }
      else
        format.html { render action: "new" }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
        format.xml { render xml: @journey.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /trains/journey/1
  # DELETE /trains.journey/1.json
  # DELETE /trains/journey/1.xml
  def destroy
    @journey = Journey.find(params[:id])
    render_404 and return if @journey.nil?
    render_403 and return if @journey.user_id != current_user.id
    @journey.destroy

    respond_to do |format|
      format.html { redirect_to journeys_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


end
