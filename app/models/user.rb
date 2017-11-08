class User < ApplicationRecord
  has_secure_password

  belongs_to :team
  has_many :messages
  has_many :captures
  has_many :flags, through: :captures
  has_many :stunners, :class_name => 'Stun', :foreign_key => 'stunner_id'
  has_many :stunnees, :class_name => 'Stun', :foreign_key => 'stunnee_id'

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def grab(flag_id)
    flag = Flag.find(flag_id)
    if time_stunned == nil && self.has_flag != true && self.distance_to(flag) <= 0.01 && flag.base.team_id != self.team_id
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
      return "You can't do that."
    end
  end

  def retrieve(flag_id)
    flag = Flag.find(flag_id)
    if self.time_stunned == nil && self.has_flag != true && self.distance_to(flag) <= 0.01 && flag.team_id == self.team_id && flag.captures.length > 0
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
      return "You rescued your flag!"
    else
      p "You can't do that."
    end
  end

  def bring_back(flag, base, original_base, capture)
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
    original_base.create_flag
    return "You returned your team's flag!"
  end

  def score_point(flag, base, original_base, capture)
    capture.assign_attributes(success: true)
    capture.save
    self.assign_attributes(
                          points: self.points + 50,
                          has_flag: false
                          )
    self.save
    self.team.assign_attributes(score: self.team.score + 1)
    self.team.save
    original_base.create_flag
    return "SCORE! You returned an enemy flag to your base."
  end

  def stun(enemy_id)
    enemy = User.find(enemy_id)
    if enemy.team_id != self.team_id && self.distance_to(enemy) <= 0.01
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
      return "You can't do that."
    end
  end

  def go_to(item)
    self.latitude = item.latitude
    self.longitude = item.longitude
    self.save
  end

  def current_flag
    self.captures.where(success: nil).first.flag
  end
end
