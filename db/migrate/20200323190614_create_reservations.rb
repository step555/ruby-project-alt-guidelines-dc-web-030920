class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :car_id
      t.datetime :pickup_date
      t.datetime :dropoff_date
      t.integer :trip_duration
    end
  end
end
