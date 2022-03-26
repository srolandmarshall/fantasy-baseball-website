class Team < ApplicationRecord
  has_many :players, optional: true
  
  def to_s
    name
  end
  
end
