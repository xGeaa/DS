class AddLuminosidadToDispositivos < ActiveRecord::Migration[8.1]
  def change
    add_column :dispositivos, :luminosidad, :integer
  end
end
