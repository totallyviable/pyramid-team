class Team < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def members?
    members.size
  end

  def to_param
    name
  end

  def self.from_param(param)
    self.where('lower(name) = ?', param.downcase).first
  end
end
