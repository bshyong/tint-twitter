class ChangeDefaultBattleStateToActive < ActiveRecord::Migration
  def up
    change_column :battles, :active, :boolean, :default => true
  end

  def down

  end
end
