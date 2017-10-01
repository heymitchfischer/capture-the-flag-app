class Flag < ApplicationRecord
  belongs_to :base
  has_many :captures

  def initialize(array)
    latitude = array[0]
    longitude = array[1]
    base_id = array[2]
  end
end
