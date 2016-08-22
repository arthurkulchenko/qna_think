class Vote < ApplicationRecord
  belongs_to :ballot, polymorphic: true

  def up
    mark += 1	
  end

  def down
    mark -= 1	
  end

end
