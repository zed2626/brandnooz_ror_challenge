class Product < ApplicationRecord
  has_many :product_tags, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :product_tags, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :price_cents, presence: true
  validates :price_currency, presence: true
  validates :product_tags_count, numericality: { greater_than_or_equal_to: 3 }

  monetize :price_cents

  def product_tags_count
    product_tags.size
  end
end
