

# User.create(name: Faker::Name.name)
# Reservation.create(name: Faker::Company.name)
# Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart)


# user1 = User.create(username: Faker::Name.name, age: Faker::Age.age)
# car1 = Car.create(make: Faker::Make.make, model: Faker::Model.model, year: Faker::Year.year)
# res1 = Reservation.create(user_id: user1.id, car_id: car1.id)


user1 = User.create(username: "Tyler", age: 20)
user2 = User.create(username: "Hermione", age: 30)
user3 = User.create(username: "Bob", age: 57)
user4 = User.create(username: "Margaret", age: 92)
user5 = User.create(username: "Andy", age: 42)

car1 = Car.create(make: "Ford", model: "Focus ST", year: 2014, license_plate: "TIK TOK", price_per_day: 55.99)
car2 = Car.create(make: "Mazda", model: "3", year: 2016, license_plate: "Z00MZ00M", price_per_day: 49.99)
car3 = Car.create(make: "Toyota", model: "Prius", year: 2018, license_plate: "GO GRN", price_per_day: 42.99)
car4 = Car.create(make: "Honda", model: "Accord", year: 2015, license_plate: "FHE12345", price_per_day: 62.99)

res1 = Reservation.create(user_id: user2.id, car_id: car1.id, trip_duration: 4, pickup_date: '2020-12-20 12:00:00', dropoff_date: '2020-12-24 11:00:00')
res2 = Reservation.create(user_id: user4.id, car_id: car3.id, trip_duration: 10, pickup_date: '2020-06-01 07:30:00', dropoff_date: '2020-06-11 11:45:00')
res3 = Reservation.create(user_id: user3.id, car_id: car2.id, trip_duration: 1, pickup_date: '2020-11-27 13:00:00', dropoff_date: '2020-11-28 10:00:00')
res4 = Reservation.create(user_id: user5.id, car_id: car4.id, trip_duration: 7, pickup_date: '2020-1-10 10:00:00', dropoff_date: '2020-1-17 10:00:00')
res5 = Reservation.create(user_id: user2.id, car_id: car4.id, trip_duration: 2, pickup_date:'2020-11-20 14:00:00', dropoff_date: '2020-11-22 10:00:00')

# https://stackoverflow.com/questions/1933720/how-do-i-insert-datetime-value-into-a-sqlite-database  
# t.integer :user_id
# t.integer :car_id
# t.datetime :pickup_date
# t.datetime :dropoff_date
# t.integer :trip_duration
# DateTime.new(2001,2,3,4,5,6)
# YMD H:M:S
# 0000-00-00 00:00:00