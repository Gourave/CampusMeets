class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :mid
      t.string :uid1
      t.string :uid2
      t.datetime :expires_at

      t.timestamps
    end
  end
end
