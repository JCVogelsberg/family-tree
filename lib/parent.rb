class Parent < ActiveRecord::Base
  has_many :people, class_name: "Person", foreign_key: "person1_id"

  def self.find_spouse(first_spouse)
    person_spouse_id = nil

    self.all.each do |couple|
      case first_spouse.id
      when couple.person1_id
        person_spouse_id = couple.person2_id
      when couple.person2_id
        person_spouse_id = couple.person1_id
      end
    end
    spouse = Person.find(person_spouse_id)
  end
end
