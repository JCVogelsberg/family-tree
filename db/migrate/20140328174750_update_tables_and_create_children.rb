class UpdateTablesAndCreateChildren < ActiveRecord::Migration
  def change
    remove_column :people, :parent_id
    create_table :parents_people do |t|
      t.column :person_id, :int
      t.column :parent_id, :int
    end
  end
end
