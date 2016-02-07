class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.belongs_to :track, index: true
      t.column :show_name, :string
      t.column :min_units, :integer
      t.column :min_courses, :integer
      t.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
