class User < ApplicationRecord
  include Clearance::User
  enum role: [:teacher, :family, :student, :admin]
  ratyrate_rater
  before_save {email.downcase!}
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, uniqueness: {case_sensitive: false}
  validates :country, presence: true
  validates :password, length: { minimum: 5 }, allow_nil: true
  validates_acceptance_of :terms, :allow_nil => false,
  :accept => true
  has_many :documents, dependent: :destroy
  has_many :diyprojects, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :receiver_id
  

end

