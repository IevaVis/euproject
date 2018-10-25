class User < ApplicationRecord
  include Clearance::User
  enum role: [:teacher, :family, :student, :admin]
  ratyrate_rater
  validates :name, :email, :country, presence: true
  validates :email, format: { with: /\S+@\S+\.\S+/, message: "Not a valid email" } 
	validates :email, uniqueness: true 
  has_many :documents, dependent: :destroy
  has_many :diyprojects, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :receiver_id
  

end

