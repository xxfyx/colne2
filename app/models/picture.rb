class Picture < ApplicationRecord
  belongs_to :post,inverse_of: :pictures

  has_attached_file :image, styles: {original: "700x450>", thumb: "170x90>"}
  validates_attachment :image, presence: true,
  content_type: { content_type: ["image/jpeg", "image/jpeg", "image/png"] },
  size: { in: 0..1500.kilobytes }

validate :image_count_within_limit, :on => :create
  def image_count_within_limit
    if self.post.pictures(:reload).count >= 5
      errors.add(:base, "Exceeded thing limit is 5")
    end
  end



end
