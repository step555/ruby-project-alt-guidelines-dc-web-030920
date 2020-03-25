class User < ActiveRecord::Base
    has_many :reservations
    has_many :cars, through: :reservations
    
#creates a new reservation and saves it to the database ** This should stay in User class 
    def create_reservation(carid, pd, dd, trip_d)
        res = Reservation.create(user_id: self.id, car_id: carid, pickup_date: pd, dropoff_date: dd, trip_duration: trip_d, paid: false) 
    end

#changes all reservations to paid ** This should stay in User class 
    def change_all_reservations_to_paid
        self.reservations.each do |r|
            r.paid = true
            r.save
        end
    end
  
end