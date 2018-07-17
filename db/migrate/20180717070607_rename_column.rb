class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :date, :start_time
  end
end
