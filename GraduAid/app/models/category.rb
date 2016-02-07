class Category < ActiveRecord::Base
  belongs_to :track
  has_many :requirements
end
