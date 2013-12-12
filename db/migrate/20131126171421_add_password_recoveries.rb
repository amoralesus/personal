class AddPasswordRecoveries < ActiveRecord::Migration
  def change
    create_table "password_recoveries", force: true do |t|
      t.integer  "user_id"
      t.string   "status"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "token"
    end
  end
end
