class CreateTakens < ActiveRecord::Migration
  def up
    create_table :takens, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.column :grade,      :string
      t.column :unit,       :integer
    end
  end

  def down
    drop_table :takens
  end
end
