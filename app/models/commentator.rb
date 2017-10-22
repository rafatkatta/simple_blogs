class Commentator < ApplicationRecord
    has_many :comments
    
    def name
        "#{firasname} #{lastname}"
    end
end
