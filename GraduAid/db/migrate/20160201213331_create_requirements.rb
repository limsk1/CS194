class CreateRequirements < ActiveRecord::Migration
  def up
    create_table :requirements do |t|
      t.belongs_to :category, index: true
      t.column :course_id, :integer
      t.column :num_courses, :integer
      t.column :criteria, :string
      t.column :priority, :integer
      t.column :repeatable, :boolean
      t.timestamps    
    end
  end

  def down
    drop_table :requirements
  end
end
