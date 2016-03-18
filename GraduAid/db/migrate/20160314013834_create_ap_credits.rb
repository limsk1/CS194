class CreateApCredits < ActiveRecord::Migration
  def change
    create_table :ap_credits do |t|
      t.column :name, :string
      t.column :grade, :int
      t.column :taken, :boolean, :default => false
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
