class Tube::LinesController < ApplicationController


  # GET /tube/lines
  # GET /tube/lines.json
  # GET /tube/lines.xml
  def index
    @q = params['q']

    if @q && !@q.empty?
      @lines = Tube::Line.where("name LIKE ? OR name LIKE ?", @q, "#{@q}%").page(params[:page])
    else
      @lines = Tube::Line.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.xml { render xml: @lines }
      format.json { render json: @lines, callback: params['callback'] }
    end
  end


  # GET /tube/lines/1
  # GET /tube/lines/1.json
  # GET /tube/lines/1.xml
  def show
    @line = Tube::Line.find_by! uuid: params[:uuid]

    respond_to do |format|
      format.html
      format.xml { render xml: @line }
      format.json { render json: @line, callback: params['callback'] }
    end
  end


end
