class Operator < ActiveRecord::Base

  def to_s
    name
  end

  def url
     "/operators/" + code
  end

end
