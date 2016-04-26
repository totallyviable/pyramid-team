class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :memberships
  has_many :teams, through: :memberships

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def team
    teams.first
  end

  def team?
    teams.size
  end

  def team=(team)
    team.memberships.find_or_create_by!(user: self)
  end

  def to_param
    username
  end

  def self.from_param(param)
    self.where('lower(username) = ?', param.downcase).first
  end
end
