class Tube::Station < ActiveRecord::Base
  has_and_belongs_to_many :train_lines
end
