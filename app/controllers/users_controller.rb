class UsersController < ApplicationController
  include ApplicationHelper
  include ErrorHelper


  # GET /users/1
  # GET /users/1.json
  # GET /users/1.xml
  def show
    @user = User.find_by username: params[:username]
    render_404 and return unless @user

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


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if needs_password?(current_user, user_params)
       save = current_user.update(user_params)
     else
       save = current_user.update_without_password(user_params)
     end

    respond_to do |format|
      if save
        format.html { redirect_to current_user.url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :home_station_id, :work_station_id)
  end


  def needs_password?(user, params)
    params[:password].present?
  end


end
