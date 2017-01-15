require 'will_paginate/array'
class JourneyLegsController < ApplicationController
  before_filter :authenticate_user!


  # GET /journeys/1/legs/1
  # GET /journeys/1/legs/1.json
  # GET /journeys/1/legs/1.xml
  def show
    @journey = Journey.find(params[:journey_id])
    @journey_leg = JourneyLeg.find_by id: params[:id], journey_id:  @journey.id
    render_404 and return if @journey_leg.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journey_leg, callback: params[:callback] }
      format.xml { render xml: @journey_leg }
    end
  end


  # GET /journeys/1/legs/new
  # GET /journeys/1/legs/new.json
  # GET /journeys/1/legs/new.xml
  def new

    if params[:journey_id]
      @journey = Journey.find(params[:journey_id])
      render_403 and return if @journey.user_id != current_user.id

      @journey_leg = JourneyLeg.new
      @url = "/journeys/#{@journey.id}/legs"
    elsif params[:journey_leg]
      @journey_leg = JourneyLeg.new(journey_leg_params)
      @url = "/journeys"
    else
      @journey_leg = JourneyLeg.new
      @url = "/journeys"
    end

    @method = :POST

    @stations = Station.order(:name)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @journey_leg, callback: params[:callback] }
      format.xml { render xml: @journey_leg }
    end
  end


  # GET /journeys/1/legs/1/edit
  def edit
    @journey = Journey.find(params[:journey_id])
    render_403 and return if @journey.user_id != current_user.id

    @journey_leg = JourneyLeg.find_by id: params[:id], journey_id:  @journey.id

    @url = "/journeys/#{@journey.id}/legs/#{@journey_leg.id}"
    @method = :PUT
  end


  # POST /journeys/1/legs
  # POST /journeys/1/legs.json
  # POST /journeys/1/legs.xml
  # POST /journeys
  # POST /journeys.json
  # POST /journeys.xml
  def create

    if params[:journey_id]
      @journey = Journey.find(params[:journey_id])
      render_403 and return if @journey.user_id != current_user.id
    else
      @journey = Journey.create(user_id: current_user.id)
    end

    @url = "/journeys/#{@journey.id}/legs"
    @method = :POST
    @journey_leg = JourneyLeg.new(journey_leg_params.merge(journey_id: @journey.id))

    respond_to do |format|
      if @journey_leg.save
        format.html { redirect_to @journey, notice: 'Journey leg was successfully created.' }
        format.json { render json: @journey, status: :created, location: @journey }
        format.xml { render xml: @journey, status: :created, location: @journey }
      else
        format.html { render action: "new" }
        format.json { render json: @journey_leg.errors, status: :unprocessable_entity }
        format.xml { render xml: @journey_leg.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /journeys/1/legs/1
  # PUT /journeys/1/legs/1.json
  # PUT /journeys/1/legs/1.xml
  def update
    @journey = Journey.find(params[:journey_id])
    render_404 and return if @journey.nil?
    render_403 and return if @journey.user_id != current_user.id

    @journey_leg = JourneyLeg.find_by id: params[:id], journey_id: @journey.id
    render_404 and return if @journey_leg.nil?

    respond_to do |format|
      if @journey_leg.update_attributes(journey_leg_params)
        format.html { redirect_to @journey, notice: 'Journey leg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @journey_leg.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /journeys/1/legs/1
  # DELETE /journeys/1/legs/1.json
  # DELETE /journeys/1/legs/1.xml
  def destroy
    @journey_leg = Trains::JourneyLeg.find_by id: params[:id], journey_id: params[:journey_id]
    render_404 and return if @journey_leg.nil?
    render_403 and return if @journey_leg.journey.user_id != current_user.id

    @journey_leg.destroy

    respond_to do |format|
      format.html { redirect_to @journey_leg.journey }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def journey_leg_params
      params.require(:journey_leg).permit(
        :departure_station_id,
        :departure_platform,
        :scheduled_departure,
        :actual_departure,
        :arrival_station_id,
        :arrival_platform,
        :scheduled_arrival,
        :actual_arrival,
        :operator_id
      )
    end

    def journey_leg_url
      "#{journeys_path}/#{self.journey.id}/legs/#{self.id}"
    end

end
