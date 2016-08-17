class Picture < ApplicationRecord
  belongs_to :post
  has_attached_file :image, styles: {thumb: "150x150"}
      validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
