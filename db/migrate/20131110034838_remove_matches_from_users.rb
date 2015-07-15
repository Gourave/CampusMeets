class RemoveMatchesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :matches, :string
  end
end
