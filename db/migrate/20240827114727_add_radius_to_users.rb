class AddRadiusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :radius, :integer
  end
end
