class CreateFulfillments < ActiveRecord::Migration
  def up
    create_table :fulfillments do |t|
      t.belongs_to :requirement, index: true
      t.belongs_to :course, index: true
      t.timestamps
    end
  end

  def down
    drop_table :fulfillments
  end
end
