class User < ApplicationRecord
  include Clearance::User
  enum role: [:teacher, :family, :student, :admin]
  validates :name, :country, presence: true
  has_many :documents
  has_many :diyprojects
  has_many :chatrooms

end

