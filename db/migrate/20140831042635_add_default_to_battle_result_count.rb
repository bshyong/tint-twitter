class AddDefaultToBattleResultCount < ActiveRecord::Migration
  def up
    change_column :battle_results, :count, :integer, default: 0
  end

  def down
    # left empty because non reversible
  end
end
