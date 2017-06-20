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

  def product_tags_names
    product_tags.map(&:name)
  end

  def five_most_similar_products
    product_id_with_matching_tags_count.sort_by { |_key, value| value }.reverse[0..4]
  end

  private

  def all_products_ids_with_same_product_tags
    product_tags_names.map do |product_tags_name|
      ProductTag.products_id_with_tag_name(product_tags_name)
    end.flatten.reject { |elm| elm == id }
  end

  def product_id_with_matching_tags_count
    product_id_matching_tags = Hash.new(0)

    all_products_ids_with_same_product_tags.each do |product_id|
      product_id_matching_tags[product_id] += 1
    end

    product_id_matching_tags
  end
end
