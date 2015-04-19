class TimetablesController < ApplicationController
  include ApplicationHelper


  # GET /timetables/1
  # GET /timetables/1.json
  # GET /timetables/1.xml
  def show
    @timetable = Timetable.where(uuid: params[:uuid]).first

    respond_to do |format|
      format.html
      format.xml { render xml: @timetable }
      format.json { render json: @timetable, callback: params['callback'] }
    end
  end


end
