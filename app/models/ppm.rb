class Ppm < ActiveRecord::Base
  belongs_to :station
  default_scope { order('created_at DESC') }

end
