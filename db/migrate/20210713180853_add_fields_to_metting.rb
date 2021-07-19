class AddFieldsToMetting < ActiveRecord::Migration[6.1]
  def change
    add_column :mettings, :reschedule, :datetime
  end
end
