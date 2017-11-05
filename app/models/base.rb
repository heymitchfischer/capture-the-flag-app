class Base < ApplicationRecord
  belongs_to :team
  has_many :flags

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def create_flag
    flag = Flag.new(latitude: self.latitude, 
                    longitude: self.longitude, 
                    base_id: self.id)
    flag.save
  end
end
