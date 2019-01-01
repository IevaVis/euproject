class Chatroom < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :users, through: :comments
	validates :title, presence: true, length: { maximum: 100}
	validates :description, presence: true, length: { maximum: 2000}
end
