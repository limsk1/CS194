class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.column :email,      :string
      t.column :first_name, :string
      t.column :last_name,  :string
      t.column :password_digest, :string
      t.column :salt,       :string
      t.column :track_id,   :integer
      t.column :profile_file_path, :string, :default => "logo.png"
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
