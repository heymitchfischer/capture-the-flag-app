class Stun < ApplicationRecord
  belongs_to :stunner, :class_name => 'User', :foreign_key => 'stunner_id'
  belongs_to :stunnee, :class_name => 'User', :foreign_key => 'stunnee_id'
end
