class AddSlugToTeaching < ActiveRecord::Migration
  def change
    add_column :teachings, :slug, :string#, null: false
    add_index :teachings, :slug, unique: true
  end
end
