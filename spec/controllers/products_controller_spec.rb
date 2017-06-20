require 'rails_helper'

RSpec.describe ProductsController do
  let(:product) do
    product = Product.new
    product.name = 'product_name1'
    product.price = 123

    product_tag1 = ProductTag.new(name: 'tag1')
    product_tag2 = ProductTag.new(name: 'tag2')
    product_tag3 = ProductTag.new(name: 'tag3')

    product.product_tags << [product_tag1, product_tag2, product_tag3]

    product.save!

    product
  end

  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template(:index) }
  end

  describe '#show' do
    subject { get :show, params: { id: product.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template(:show) }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe '#create' do
    subject { post :create, params: params }

    context 'with valid params' do
      let(:params) do
        {
          'product[name]': :product_name1,
          'product[price]': 123,
          'product[product_tags_attributes][0][name]': :tag1,
          'product[product_tags_attributes][1][name]': :tag2,
          'product[product_tags_attributes][2][name]': :tag3
        }
      end

      it { is_expected.to have_http_status(302) }
      it { expect{ is_expected }.to change(Product, :count).by(1) }
    end

    context 'with invalid params' do
      let(:params) do
        {
          'product[name]': :product_name1,
          'product[price]': 123
        }
      end

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template(:new) }
      it { expect{ is_expected }.to change(Product, :count).by(0) }
    end
  end

  describe '#edit' do
    subject { get :edit, params: { id: product.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template(:edit) }
  end

  # describe '#update' do
  #   subject do
  #     put :update, params: params
  #   end
  #
  #   context 'with new valid params' do
  #     let(:params) do
  #       {
  #         id: product.id,
  #         'product[name]': :new_product_name1,
  #         'product[price]': 123,
  #         'product[product_tags_attributes][0][name]': :tag1,
  #         'product[product_tags_attributes][1][name]': :tag2,
  #         'product[product_tags_attributes][2][name]': :tag3
  #       }
  #     end
  #
  #     it { is_expected.to have_http_status(302) }
  #     it { is_expected.to render_template(:edit) }
  #   end
  #
  #   context 'with new invalid params' do
  #     let(:params) do
  #       {
  #         id: product.id,
  #         'product[name]': :new_product_name1,
  #         'product[price]': 123
  #       }
  #     end
  #
  #     it { is_expected.to have_http_status(302) }
  #     it { is_expected.to render_template(:edit) }
  #   end
  # end

  # describe '#destroy' do
  #   subject do
  #     product
  #     delete :destroy, params: { id: product.id }
  #   end
  #
  #   it { is_expected.to have_http_status(302) }
  #   it { expect{ is_expected }.to change(Product, :count).from(1).to(0) }
  # end
end
