class Person < ActiveRecord::Base
  validates :name, :presence => true

#  after_save :make_marriage_reciprocal

  # def spouse
  #   if spouse_id.nil?
  #     nil
  #   else
  #     Person.find(spouse_id)
  #   end
  # end

private

  # def make_marriage_reciprocal
  #   if parents_id_changed?
  #     parents.update(:spouse_id => id)
  #   end
  # end
end
