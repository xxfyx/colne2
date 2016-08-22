class Picture < ApplicationRecord
  belongs_to :post,inverse_of: :pictures

  has_attached_file :image, styles: {medium: "600x450>", thumb: "350x250>"}
  validates_attachment :image, presence: true,
  content_type: { content_type: ["image/jpeg", "image/jpeg", "image/png"] },
  size: { in: 0..1000.kilobytes }

     
end
