class Comment < ApplicationRecord
  belongs_to :massege
  belongs_to :commentator
end
