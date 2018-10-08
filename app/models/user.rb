class User < ApplicationRecord
  include Clearance::User
  enum role: [:teacher, :family, :student, :admin]
  validates :name, :country, presence: true
  has_many :documents, dependent: :destroy
  has_many :diyprojects, dependent: :destroy
  has_many :chatrooms, dependent: :destroy

end

