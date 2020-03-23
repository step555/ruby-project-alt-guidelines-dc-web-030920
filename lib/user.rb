class User < ActiveRecord::Base
    has_many :reservations
    has_many :cars, through: :reservations
    
end