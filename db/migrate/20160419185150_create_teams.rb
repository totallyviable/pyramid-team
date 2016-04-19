class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :owner
      
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :teams, :name, unique: true
  end
end
