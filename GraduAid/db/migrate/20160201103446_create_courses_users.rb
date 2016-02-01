class CreateCoursesUsers < ActiveRecord::Migration
  def up
    create_table :courses_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.column :grade,      :string
      t.column :unit,       :integer
    end
  end

  def down
    drop_table :courses_users
  end
end
