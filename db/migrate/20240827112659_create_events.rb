class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.string :location
      t.references :user, null: false, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
