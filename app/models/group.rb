class Group < ActiveRecord::Base
  belongs_to :user
  has_many :memberships
  has_many :groups, through: :memberships

  validates :name, presence: true
  validates :user, presence: true
end
