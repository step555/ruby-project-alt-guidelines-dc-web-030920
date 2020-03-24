class Car < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations
    # has_many :reviews, through: :reservations

end