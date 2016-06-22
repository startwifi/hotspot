class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.references :company, index: true
      t.string :action
      t.string :link_redirect
      t.string :wall_head
      t.text :wall_text
      t.string :wall_image
      t.boolean :adv, default: false
    end
  end
end
