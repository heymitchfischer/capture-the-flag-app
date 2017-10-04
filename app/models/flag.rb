class Flag < ApplicationRecord
  belongs_to :base
  has_many :captures

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode 
end
