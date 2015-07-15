class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :uid1
      t.string :uid2
      t.integer :weight

      t.timestamps
    end
  end
end
