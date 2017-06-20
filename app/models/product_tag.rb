class ProductTag < ApplicationRecord
  belongs_to :product, inverse_of: :product_tags

  validates :product, presence: true
  validates :name, uniqueness: { scope: :product_id }

  scope :select_tags_by_name, ->(tag_name) { where(name: tag_name) }
  scope :count_used_over_all_product_with_tag_name, ->(tag_name) { select_tags_by_name(tag_name).count }
  scope :products_id_with_tag_name, ->(tag_name) { select_tags_by_name(tag_name).pluck(:product_id) }
end
