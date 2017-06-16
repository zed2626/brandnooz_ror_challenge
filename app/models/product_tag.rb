class ProductTag < ApplicationRecord
  belongs_to :product, inverse_of: :product_tags

  validates :product, presence: true
  validates :name, uniqueness: { scope: :product_id }
end
