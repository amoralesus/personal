class AddUser < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string   "email"
      t.string   "password_digest"
      t.string   "full_name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
