class User < ApplicationRecord
  has_secure_password

  belongs_to :team
  has_many :messages
  has_many :captures
  has_many :stunners, :class_name => 'Stun', :foreign_key => 'stunner_id'
  has_many :stunnees, :class_name => 'Stun', :foreign_key => 'stunnee_id'

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def grab
    if time_stunned == nil
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
          return "The flag is yours!"
        else
          return "That's your flag."
        end
      else
        return "Not close enough to a flag."
      end
    else
      return "You're currently stunned!"
    end
  end

  def rescue
    if time_stunned == nil
      all_flags = Flag.near([self.latitude, self.longitude], 0.006)
      if all_flags.any?
        other_flags = []
        all_flags.each do |flag|
          if flag.base.team.id == team_id
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
          return "You saved your flag!"
        else
          return "That's the enemy's flag. Capture it!"
        end
      else
        return "Not close enough to a flag."
      end
    else
      return "You're currently stunned!"
    end
  end

  def return
    if self.has_flag
      bases = Base.near([self.latitude, self.longitude], 0.006)
      capture = self.captures.where(success: nil).first
      flag = Flag.find(capture.flag_id)
      if bases.any? && self.team_id == bases[0].team_id
        if self.team_id == flag.base.team_id
          capture.assign_attributes(success: false)
          capture.save
          self.assign_attributes(
                                points: self.points + 10,
                                has_flag: false
                                )
          self.save
          flag.assign_attributes(
                                latitude: nil,
                                longitude: nil
                                )
          flag.save
          Base.find(flag.base_id).create_flag
          return "You returned your team's flag!"
        elsif self.team_id != flag.base.team_id
          capture.assign_attributes(success: true)
          capture.save
          self.assign_attributes(
                                points: self.points + 50,
                                has_flag: false
                                )
          self.save
          self.team.assign_attributes(score: self.team.score + 1)
          self.team.save
          Base.find(flag.base_id).create_flag
          return "SCORE! You returned an enemy flag to your base."
        end
      else
        return "Not close enough to your base."
      end
    else
      return "You have no flag to return."
    end
  end

  def stun(enemy_id)
    enemy = User.find(enemy_id)
    if enemy.team_id == self.team_id
      return "#{enemy.name} is on your team!"
    elsif self.distance_to(enemy) <= 0.006
      stun = Stun.new(
                      stunner_id: self.id,
                      stunnee_id: enemy_id
                      )
      stun.save
      enemy.assign_attributes(time_stunned: stun.created_at)
      enemy.save
      self.assign_attributes(points: self.points + 2)
      self.save
      if enemy.has_flag
        capture = enemy.captures.where(success: nil).first
        flag = Flag.find(capture.flag_id)
        enemy.assign_attributes(has_flag: false)
        capture.assign_attributes(success: false)
        flag.assign_attributes(latitude: enemy.latitude, longitude: enemy.longitude)
        flag.save
        enemy.save
        capture.save
        return "You stunned #{enemy.name}! They dropped the flag!"
      else
        return "You stunned #{enemy.name}!"
      end
    else
      return "Too far away."
    end
  end

  def go_to(item)
    self.latitude = item.latitude
    self.longitude = item.longitude
    self.save
  end
end
