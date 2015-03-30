class BadgesController < ApplicationController
  include ApplicationHelper


  # GET /badges
  # GET /badges.json
  # GET /badges.xml
  def index
    @badges = Badge.page(params[:page])

    respond_to do |format|
      format.html
      format.xml { render xml: @badges }
      format.json { render json: @badges, callback: params['callback'] }
    end
  end


  # GET /badges/1
  # GET /badges/1.json
  # GET /badges/1.xml
  def show
    @badge = Badge.find_by! uuid: params[:uuid]

    respond_to do |format|
      format.html
      format.xml { render xml: @badge }
      format.json { render json: @badge, callback: params['callback'] }
    end
  end

end
