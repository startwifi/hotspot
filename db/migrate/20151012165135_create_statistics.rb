class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :user, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.string :provider
      t.string :platform
      t.string :platform_version
      t.string :browser
      t.string :browser_version
      t.string :mac

      t.timestamps null: false
    end
  end
end
