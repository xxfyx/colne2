class Picture < ApplicationRecord
  belongs_to :post,inverse_of: :pictures
  has_attached_file :image, styles: {medium: "600x450>", thumb: "350x250>"}
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
