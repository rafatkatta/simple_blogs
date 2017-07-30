class Massege < ApplicationRecord
  belongs_to :blog
  has_many :comments  
end
