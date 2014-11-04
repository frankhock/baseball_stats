class CreateBattings < ActiveRecord::Migration
  def change
    create_table :battings do |t|
      t.integer :player_id
      t.integer :year
      t.string  :league
      t.string  :team
      t.integer :g
      t.integer :at_bats
      t.integer :r
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :runs_batted_in
      t.integer :sb
      t.integer :cs
    end

    add_index :battings, :player_id
  end
end
