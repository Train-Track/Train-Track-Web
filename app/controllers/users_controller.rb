class UsersController < ApplicationController
  include ApplicationHelper


  # GET /users/1
  # GET /users/1.json
  # GET /users/1.xml
  def show
    @user = User.find_by username: params[:username]

    @og = {
        "og:title" => @user,
        "og:type" => "train-track:user",
        "og:url" => request.original_url,
        "og:image" => @user.image_url,
        "og:site_name" => "Train Track",
        "fb:app_id" => "272514462916508",
        "train-track:username" => @user.username
      }

    respond_to do |format|
      format.html
      format.xml { render xml: @user }
      format.json { render json: @user, callback: params['callback'] }
    end
  end


end
