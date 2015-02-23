class OperatorsController < ApplicationController
  include ApplicationHelper


  # GET /operators
  # GET /operators.json
  # GET /operators.xml
  def index    
    @operators = Operator.page(params[:page])

    respond_to do |format|
      format.html
      format.xml { render xml: @operators }
      format.json { render json: @operators, callback: params['callback'] }
    end
  end


  # GET /operators/1
  # GET /operators/1.json
  # GET /operators/1.xml
  def show
    @operator = Operator.find_by code: params[:code]

    @og = {
        "og:title" => @operator,
        "og:type" => "train-track:operator",
        "og:url" => request.original_url,
        "og:image" => "",
        "og:site_name" => "dyl.anjon.es",
        "fb:app_id" => "272514462916508",
        "train-track:code" => @operator.code
      }

    respond_to do |format|
      format.html
      format.xml { render xml: @operator }
      format.json { render json: @operator, callback: params['callback'] }
    end
  end


end