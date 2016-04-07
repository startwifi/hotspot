class ChangeMacColumnTypeInStatistics < ActiveRecord::Migration
  def up
    remove_column :statistics, :mac
    add_column :statistics, :mac, :macaddr
  end

  def down
    remove_column :statistics, :mac
    add_column :statistics, :mac, :string
  end
end
