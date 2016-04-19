class AddNewFieldsToTeaching < ActiveRecord::Migration
  def change
    add_column :teachings, :approved, :boolean, default: false
    add_column :teachings, :invisible, :boolean, default: false
  end
end
