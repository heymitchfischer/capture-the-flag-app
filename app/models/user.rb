class User < ApplicationRecord
  has_secure_password

  belongs_to :team
  has_many :messages

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def capture
    all_flags = Flag.near([self.latitude, self.longitude], 0.006)
    if all_flags.any?
      other_flags = []
      all_flags.each do |flag|
        if flag.base.team.id != team_id
          other_flags << flag
        end
      end
      if other_flags.any?
        flag = other_flags[0]
        capture = Capture.new(
                              flag_id: flag.id,
                              user_id: self.id,
                              )
        capture.save
        flag.latitude = nil
        flag.longitude = nil
        flag.save
        self.has_flag = true
        self.save
        p "The flag is yours!"
      else
        p "That's your flag."
      end
    else
      p "Not close enough to a flag."
    end
  end
end
