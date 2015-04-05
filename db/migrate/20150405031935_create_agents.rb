class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.integer :worth
      t.string :agentType

      t.timestamps null: false
    end
    add_index :agents, :name, unique: true
  end
end
