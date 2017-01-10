class ServicesController < ApplicationController
  include ApplicationHelper


  # GET /services/1
  # GET /services/1.json
  # GET /services/1.xml
  def show
    @service = Service.get_service params[:service_id]

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

    respond_to do |format|
      format.html
      format.xml { render xml: @service }
      format.json { render json: @service, callback: params['callback'] }
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
