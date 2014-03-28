class Person < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :parent
end
