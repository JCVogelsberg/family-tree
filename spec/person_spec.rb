require 'spec_helper'

describe Person do
  it { should validate_presence_of :name }
  it { should belong_to :parent }
  it "updates the parent's id when its parents_id is changed" do
    steve = Person.create(:name => 'Steve')
    couple = Parent.create(:person1_id => 15, :person2_id => 25)
    steve.update(:parent_id => couple.id)
    steve.parent_id.should eq couple.id
  end
end

