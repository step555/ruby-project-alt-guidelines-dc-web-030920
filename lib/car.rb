class Car < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations
    belongs_to :city


    def self.display_cars
        Car.all.each do |c|
            puts "#{c.id}. #{c.make} #{c.model} #{c.year} $#{c.price_per_day} per day."
        end
    end


end