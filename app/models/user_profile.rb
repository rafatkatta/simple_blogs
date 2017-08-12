class UserProfile < ApplicationRecord
  belongs_to :user

  def name
    "#{firstname} #{lastname}"
  end
end
