class Base < ApplicationRecord
  belongs_to :team
  has_many :flags

  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def create_flag
    flag = Flag.create!([self.latitude, self.longitude, self.id])
  end
end
