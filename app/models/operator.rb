class Operator < ActiveRecord::Base
  has_many :ppms
  default_scope { order('name ASC') }

  def ppm
    ppms.first
  end

  def to_s
    name
  end

  def url
     "/operators/" + code
  end

end
