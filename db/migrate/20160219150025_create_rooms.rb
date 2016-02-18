class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name

      t.timestamps
    end

    add_reference :messages, :room, index: true, foreign_key: true

    create_table :subscriptions do |t|
      t.references :room
      t.references :user

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :room_id], unique: true
  end
end
