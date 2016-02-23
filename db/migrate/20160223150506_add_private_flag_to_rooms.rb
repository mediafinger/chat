class AddPrivateFlagToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :private, :boolean, default: false
  end
end
