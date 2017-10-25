class Commentator < ApplicationRecord
    has_many :comments
    
    def name
        "#{firstname} #{lastname}"
    end
end
