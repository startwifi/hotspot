class CreateAdminSchedulerEvents < ActiveRecord::Migration
  def change
    create_table :admin_scheduler_events do |t|
      t.string :name
      t.string :description
      t.datetime :startTime
      t.datetime :endTime
      t.string :repeat
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
