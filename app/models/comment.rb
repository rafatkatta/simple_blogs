class Comment < ApplicationRecord
  belongs_to :massege
  belongs_to :commentator
  delegate :name, to: :commentator, prefix: true
end
