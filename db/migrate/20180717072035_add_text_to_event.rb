class AddTextToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :text, :text
  end
end
