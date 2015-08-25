class CreateVks < ActiveRecord::Migration
  def change
    create_table :vks do |t|
      t.references :company, index: true, foreign_key: true
      t.string :group_id
      t.string :group_name
      t.string :action
      t.string :link_redirect
      t.text :post_text
      t.string :post_link
      t.string :post_image

      t.timestamps null: false
    end
  end
end
