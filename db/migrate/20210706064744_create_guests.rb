class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :phone
      t.text :address
      t.string :email

      t.timestamps
    end
  end
end
