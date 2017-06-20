require 'rails_helper'

RSpec.describe Product do
  it { is_expected.to have_many(:product_tags).dependent(:destroy).inverse_of(:product) }
  it { is_expected.to accept_nested_attributes_for(:product_tags).allow_destroy(true) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price_cents) }
  it { is_expected.to validate_presence_of(:price_currency) }
  # it { should validate_numericality_of(:product_tags_count).is_greater_than_or_equal_to(3) }

  it { is_expected.to monetize(:price) }
end
