class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.column :course_name,    :string
      t.column :general_req,    :string
      t.column :min_unit, :integer
      t.column :max_unit, :integer
      t.column :open_aut, :boolean
      t.column :open_win, :boolean
      t.column :open_spr, :boolean
      t.column :ap_credit, :boolean, :default => false
      t.column :views, :integer, :default => 0
      t.timestamps
    end
  end
  def down
    drop_table :courses
  end
end
