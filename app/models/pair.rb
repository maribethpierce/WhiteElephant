class Pair < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :locked, presence: true
end
