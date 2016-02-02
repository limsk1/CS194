class CreateRequirements < ActiveRecord::Migration
  def up
    create_table :requirements, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :track, index: true
      t.column :criteria, :string
    end
  end

  def down
    drop_table :requirements
  end
end
