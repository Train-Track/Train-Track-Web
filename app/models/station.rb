class Station < ActiveRecord::Base

  def to_s
    name
  end

  def url
     "/stations/" + crs
  end

end
