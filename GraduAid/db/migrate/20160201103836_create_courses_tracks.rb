class CreateCoursesTracks < ActiveRecord::Migration
  def up
    create_table :courses_tracks, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :track, index: true
      t.column :criteria, :string
    end
  end
end
