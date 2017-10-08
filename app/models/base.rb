class Base < ApplicationRecord
  belongs_to :team
  has_many :flags

  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def create_flag
    flag = Flag.new(latitude: self.latitude, 
                    longitude: self.longitude, 
                    base_id: self.id)
    flag.save
  end
end
