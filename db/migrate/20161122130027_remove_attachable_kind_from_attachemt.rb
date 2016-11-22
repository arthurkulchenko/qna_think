class RemoveAttachableKindFromAttachemt < ActiveRecord::Migration[5.0]
  def change
    remove_column :attachments, :attachable_kind, :string
  end
end
