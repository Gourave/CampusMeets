class AddMatchedWithToUsers < ActiveRecord::Migration
  def change
    add_column :users, :matchedWith, :text
  end
end
