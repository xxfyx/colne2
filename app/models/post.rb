class Post < ApplicationRecord
	belongs_to :user
	has_many :pictures,inverse_of: :post, dependent: :destroy
	accepts_nested_attributes_for :pictures, allow_destroy: true
	validates :title, :description, :price, :city, :phone, presence: true

end
