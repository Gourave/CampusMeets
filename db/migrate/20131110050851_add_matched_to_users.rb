class AddMatchedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :matched, :string
  end
end
