require 'rails_helper'

RSpec.describe ProductTag do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to validate_presence_of(:product) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:product_id) }
end
