class Group < ActiveRecord::Base
  belongs_to :user
  has_many :memberships
  has_many :users, through: :memberships
  accepts_nested_attributes_for :users

  validates :name, presence: true
  validates :user, presence: true
end
