require 'spec_helper'

describe Person do
  it { should validate_presence_of :name }

  it "updates the parent's id when its parents_id is changed" do
    steve = Person.create(:name => 'Steve')
    couple = Parent.create(:person1_id => 15, :person2_id => 25)
    steve.update(:parents_id => couple.id)
    steve.parents_id.should eq couple.id
  end
end
