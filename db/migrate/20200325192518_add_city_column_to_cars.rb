class AddCityColumnToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :city_id, :integer
  end
end
