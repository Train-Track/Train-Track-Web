class StaticPagesController < ApplicationController


  # GET /
  # GET /.json
  # GET /.xml
  def index
    if user_signed_in?
      @user = current_user

      respond_to do |format|
        format.html { render :home }
        format.xml { render xml: @user }
        format.json { render json: @user, callback: params['callback'] }
      end

    end    
  end


  # GET /help
  # GET /help.json
  # GET /help.xml
  def help
    @help = "Coming soon!"

    respond_to do |format|
      format.html
      format.xml { render xml: @help }
      format.json { render json: @help, callback: params['callback'] }
    end
  end


  # GET /terms
  # GET /terms.json
  # GET /terms.xml
  def terms
    @terms = "Coming soon!"

    respond_to do |format|
      format.html
      format.xml { render xml: @terms }
      format.json { render json: @terms, callback: params['callback'] }
    end
  end


  # GET /privacy
  # GET /privacy.json
  # GET /privacy.xml
  def privacy
    @privacy = "Coming soon!"

    respond_to do |format|
      format.html
      format.xml { render xml: @privacy }
      format.json { render json: @privacy, callback: params['callback'] }
    end
  end
end
