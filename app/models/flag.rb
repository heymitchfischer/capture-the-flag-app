class Flag < ApplicationRecord
  belongs_to :base
  belongs_to :team
  has_many :captures

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode
end
