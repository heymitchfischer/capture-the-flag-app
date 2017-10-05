class Capture < ApplicationRecord
  belongs_to :flag
  belongs_to :user
end
