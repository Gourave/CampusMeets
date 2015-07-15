class RemoveTimeFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :time, :datetime
  end
end
