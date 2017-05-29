class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :company
      t.string :position
      t.bigint :phone
      t.text :home_address
      t.string :security_question
      t.string :security_answer
      t.attachment :image
      t.integer :user_id

      t.timestamps
    end
  end
end
