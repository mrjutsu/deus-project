class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :teaching, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
