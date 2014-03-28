require 'spec_helper'

describe Parent do
  it { should have_many :people }
  it 'should have two people in it' do
    new_parents = Parent.new()
    new_parents.save
    steve = Person.create(:name => 'Steve')
    stacy = Person.create(:name => 'Stacy')
    new_parents.people << steve
    new_parents.people << stacy
    new_parents.people.should eq [steve, stacy]
  end
  describe '.show_spouse' do
    it 'take a person as input and returns the spouse(as a person)' do
      steve = Person.create(:name => 'Steve')
      stacy = Person.create(:name => 'Stacy')
      new_parents = Parent.create(:person1_id => steve.id, :person2_id => stacy.id)
      Parent.find_spouse(steve).should eq stacy
    end
  end
end
