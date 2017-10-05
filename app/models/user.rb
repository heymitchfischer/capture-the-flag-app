class User < ApplicationRecord
  has_secure_password

  belongs_to :team
  has_many :messages
  has_many :captures

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
        puts "The flag is yours!"
      else
        puts "That's your flag."
      end
    else
      puts "Not close enough to a flag."
    end
  end

  def return
    bases = Base.near([self.latitude, self.longitude], 0.006)
    capture = self.captures.where(success: nil).first
    flag = Flag.find(capture.flag_id)
    if bases.any? && self.team_id == bases[0].team_id
      if self.team_id == flag.team_id
        puts "You returned your team's flag!"
      elsif self.team_id != flag.team_id
        puts "SCORE! You returned an enemy flag to your base."
      end
    else
      puts "Not close enough to your base."
    end
  end

  # def return
  #   bases = Base.near([self.latitude, self.longitude], 0.006)
  #   if bases.any? && self.team_id == bases[0].team_id
  #     if self.team_id == self.flag.team_id
  #       puts "You returned your team's flag!"
  #     elsif self.team_id != self.flag.team_id
  #       puts "SCORE! You returned an enemy flag to your base."
  #     end
  #   else
  #     puts "Not close enough to your base."
  #   end
  # end

  def stun
    
  end
end
