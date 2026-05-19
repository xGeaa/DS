class CreateDispositivos < ActiveRecord::Migration[8.1]
  def change
    create_table :dispositivos do |t|
      t.string :nombre
      t.string :tipo
      t.string :marca
      t.string :estado
      t.float :temperatura_actual
      t.float :temperatura_deseada
      t.string :modo_clima

      t.timestamps
    end
  end
end
