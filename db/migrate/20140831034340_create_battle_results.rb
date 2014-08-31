class CreateBattleResults < ActiveRecord::Migration
  def change
    create_table :battle_results do |t|
      t.references :battle
      t.references :hashtag
      t.integer :count

      t.timestamps
      t.index [:battle_id, :hashtag_id]
      t.index [:hashtag_id, :battle_id]
    end
  end
end
