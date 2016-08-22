class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :ballot, polimorphic: true, comment: "for references", index: true
      t.integer :mark, comment: "total score", default: 0
      t.string :ballot_type, index: true
      t.timestamps
    end
  end
end
