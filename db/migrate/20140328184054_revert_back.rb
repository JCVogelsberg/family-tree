class RevertBack < ActiveRecord::Migration
  def change
    add_column :people, :parent_id, :int
    drop_table :parents_people
  end
end
