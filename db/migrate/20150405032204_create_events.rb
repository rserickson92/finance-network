class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :amount
      t.datetime :dateTime
      t.string :fromAgent
      t.string :toAgent
      t.string :eventType

      t.timestamps null: false
    end
  end
end
