class Chatroom < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :users, through: :comments
	validates :title, presence: true, length: { maximum: 50}
	validates :description, presence: true, length: { maximum: 500}
end
