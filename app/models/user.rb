class User < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :timeoutable, :registerable
  # devise + omniauth  :omniauthable
  has_many :blogs
  has_one :user_profile
  before_save {admin = true if User.count == 0}
  
  attr_accessor :firstname, :lastname, :birthday, :birth_city, :birth_country
  accepts_nested_attributes_for :user_profile, allow_destroy: true

  delegate :name,  to: :user_profile, allow_nil: true 
  delegate :firstname,  to: :user_profile, allow_nil: true
  delegate :lastname,  to: :user_profile, allow_nil: true
  delegate :birthday,  to: :user_profile, allow_nil: true
  delegate :birth_city,  to: :user_profile, allow_nil: true
  delegate :birth_country,  to: :user_profile, allow_nil: true

  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def approved?
     deactivate_at.nil?
  end
  
  def is_admin?
      admin
  end
  
end
