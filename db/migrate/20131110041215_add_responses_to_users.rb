class AddResponsesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :responses, :text
  end
end
