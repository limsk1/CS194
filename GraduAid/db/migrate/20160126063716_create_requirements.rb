class CreateRequirements < ActiveRecord::Migration
  def up
    create_table :requirements do |t|
      t.column :criteria, :string
      t.timestamps
    end
  end
  def down
    drop_table :requirements
  end
end
