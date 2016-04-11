class AddAttachmentDocumentToTeachings < ActiveRecord::Migration
  def self.up
    change_table :teachings do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :teachings, :document
  end
end
