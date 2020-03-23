class Reservation < ActiveRecord::Base
    belongs_to :cars
    belongs_to :users

end