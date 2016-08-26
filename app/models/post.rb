class Post < ApplicationRecord
	searchkick
	belongs_to :user
	belongs_to :category
	belongs_to :city
	validates :title, :description, :price, :city_id, :phone, :category_id, presence: true
	has_many :pictures,inverse_of: :post, dependent: :destroy
	accepts_nested_attributes_for :pictures, allow_destroy: true
	def search_data
		  attributes.merge(
		    category_name: category(&:name)
		  )
            end

end
