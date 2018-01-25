class AddLoyaltyColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :loyalty_points, :integer, Default: 0
  end
end
