class Post < ApplicationRecord
	searchkick
	belongs_to :user
	belongs_to :category
	belongs_to :city
	has_many :pictures,inverse_of: :post, dependent: :destroy
	validates :title, :description, :price, :city_id, :phone, :category_id, presence: true
	accepts_nested_attributes_for :pictures, allow_destroy: true

	def search_data
		#------------------> rake searchkick:reindex CLASS=Post  <------------------
		  attributes.merge(
		    category_name: category(&:name),
		    city_name: city(&:name)
		    )
        end

end
