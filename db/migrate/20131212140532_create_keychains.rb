class CreateKeychains < ActiveRecord::Migration
  def change
    create_table :keychains do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.text :description

      t.timestamps
    end
  end
end
