class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :file
      t.belongs_to :attachable, polymorphic: true, index: true
      t.string :attachable_kind, index: true, comment: "need to describe what model is use it"

      t.timestamps
    end
  end
end
