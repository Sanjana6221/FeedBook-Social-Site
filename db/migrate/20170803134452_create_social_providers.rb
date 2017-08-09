class CreateSocialProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :social_providers do |t|
    	t.string   "pid" # user provider id
      t.string   "token"
      t.string   "refresh_token"
      t.string   "secret"
      t.datetime "expires_at"
      t.string   "provider_type"
      t.integer  "user_id"
      t.string   "url"
      t.string   "email"
      t.timestamps
    end
  end
end
