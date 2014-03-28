class RenameColumnInPeople < ActiveRecord::Migration
  def change
    rename_column :people, :parents_id, :parent_id
  end
end
