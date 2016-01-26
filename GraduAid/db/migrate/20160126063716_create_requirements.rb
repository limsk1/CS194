class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|

      t.timestamps
    end
  end
end
