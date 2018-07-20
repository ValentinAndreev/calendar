class AddRecurrentEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :recurrent, :string, default: 'none'
  end
end
