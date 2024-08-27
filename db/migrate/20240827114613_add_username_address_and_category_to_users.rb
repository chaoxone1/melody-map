class AddUsernameAddressAndCategoryToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :address, :string
    add_column :users, :categories, :string
  end
end
