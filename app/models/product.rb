class Product < ApplicationRecord
  validates :name, presence: true
  validates :price_cents, presence: true
  validates :price_currency, presence: true

  monetize :price_cents
end
