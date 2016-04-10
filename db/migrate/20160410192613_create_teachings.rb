class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.string :teaching_name
      t.text :summary
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
