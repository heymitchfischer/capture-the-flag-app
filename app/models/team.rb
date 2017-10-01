class Team < ApplicationRecord
  has_many :users
  has_many :messages, through: :users
  has_many :bases
  has_many :flags, through: :bases
end
