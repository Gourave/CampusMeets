class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :uidfrom
      t.string :uidto
      t.datetime :time
      t.text :body

      t.timestamps
    end
  end
end
