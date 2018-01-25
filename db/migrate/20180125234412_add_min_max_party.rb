class AddMinMaxParty < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :min_party, :integer
    add_column :restaurants, :max_party, :integer
  end
end
