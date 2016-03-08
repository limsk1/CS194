class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.column :up,      :boolean
      t.timestamps
    end
  end
end
