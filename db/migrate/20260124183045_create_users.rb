class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :strava_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :profile_picture
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at

      t.timestamps
    end
  end
end
