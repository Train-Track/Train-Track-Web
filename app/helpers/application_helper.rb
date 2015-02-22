module ApplicationHelper

  #distance MySQL
  def distance_sql lat, lng
    return "7912*ASIN(SQRT(POWER(SIN((lat-#{lat})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{lat}*pi()/180)*POWER(SIN((lng-#{lng})*pi()/180/2),2)))"
  end

  #bootsrap 3 paginator
  def paginate page
    will_paginate page, renderer: BootstrapPagination::Rails, bootstrap: 3
  end

end
