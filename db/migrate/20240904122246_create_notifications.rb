class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.string :notification_type
      t.datetime :read_at

      t.timestamps
    end
  end
end
