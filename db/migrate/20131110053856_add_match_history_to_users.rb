class AddMatchHistoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :matchHistory, :text
  end
end
