module ErrorHelper


  def render_403
    respond_to do |format|
      format.html { render status: 403, template: 'static_pages/403' }
      format.json { render status: 403, json: { error: 403 }, callback: params[:callback] }
      format.xml { render status: 403, xml: { error: 403 } }
      format.all { render status: 403, template: 'static_pages/403.html.erb', content_type: Mime::HTML }
    end
  end


  def render_404
    respond_to do |format|
      format.html { render status: 404, template: 'static_pages/404' }
      format.json { render status: 404, json: { error: 404 }, callback: params[:callback] }
      format.xml { render status: 404, xml: { error: 404 } }
      format.all { render status: 404, template: 'static_pages/404.html.erb', content_type: Mime::HTML }
    end
  end


  def render_410
    respond_to do |format|
      format.html { render status: 410, template: 'static_pages/410' }
      format.json { render status: 410, json: { error: 410 }, callback: params[:callback] }
      format.xml { render status: 410, xml: { error: 410 } }
      format.all { render status: 410, template: 'static_pages/410.html.erb', content_type: Mime::HTML }
    end
  end


end
