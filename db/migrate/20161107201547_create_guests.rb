class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :company, index: true
      t.string :action
      t.string :link_redirect
      t.string :wall_head
      t.text :wall_text
      t.string :wall_image
      t.boolean :adv, default: false
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
