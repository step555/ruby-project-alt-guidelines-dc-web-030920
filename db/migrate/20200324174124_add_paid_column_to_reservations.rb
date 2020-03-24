class AddPaidColumnToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :paid, :boolean
  end
end


# class ChangeDatatypeForBirthdate < ActiveRecord::Migration[5.1]
#   def change
#     change_column :students, :birthdate, :datetime
#   end
# end