class Post < ApplicationRecord
	searchkick
	belongs_to :user
	has_many :pictures,inverse_of: :post, dependent: :destroy
	accepts_nested_attributes_for :pictures, allow_destroy: true
	validates :title, :description, :price, :city, :phone, presence: true

	def search_data
		  attributes.merge(
		    user_name: user(&:email)
		  )
            end

end
