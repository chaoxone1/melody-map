class AddInformationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :information, :text
  end
end
