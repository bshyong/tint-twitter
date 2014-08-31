class ChangeDefaultForBattleActiveFlag < ActiveRecord::Migration
  def up
    change_column :battles, :active, :boolean, default: false
  end

  def down
    # non reversible!
  end
end
