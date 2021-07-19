class AddFieldsToMettings < ActiveRecord::Migration[6.1]
  def change
    add_column :mettings, :reason, :text
  end
end
