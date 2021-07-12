class CreateMettings < ActiveRecord::Migration[6.1]
  def change
    create_table :mettings do |t|
      t.text :purpose
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
