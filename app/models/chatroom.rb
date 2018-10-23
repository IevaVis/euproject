class Chatroom < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :users, through: :comments
	validates :title, :description, presence: true
end
