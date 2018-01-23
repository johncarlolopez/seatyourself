class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :price_range
      t.text :summary
      t.text :menu

      t.timestamps
    end
  end
end