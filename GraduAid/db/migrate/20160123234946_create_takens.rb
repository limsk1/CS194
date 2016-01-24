class CreateTakens < ActiveRecord::Migration
  def up
    create_table :takens do |t|
      t.column :user_id,    :integer
      t.column :course_id,  :integer
      t.column :grade,      :string
      t.column :unit,       :string
      t.timestamps
    end
  end
  def down
    drop_table :takens
  end
end
