class ChangePeopleTable < ActiveRecord::Migration
  def change
    rename_column :people, :spouse_id, :parents_id

    add_column :people, :created_at, :datetime
    add_column :people, :updated_at, :datetime
  end
end
