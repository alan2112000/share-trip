class Trip < ActiveRecord::Base

  # Relation
  belongs_to :user
  has_many :locations

  # Validation
  validates_presence_of :name
end
