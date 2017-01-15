class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :type
      t.text :agreement_text
      t.string :language

      t.timestamps null: false
    end
  end
end
