class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.column :person1_id, :int
      t.column :person2_id, :int

      t.timestamps
    end
  end
end
