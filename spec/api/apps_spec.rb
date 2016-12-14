require 'spec_helper'

# https://github.com/rspec/rspec-rails

describe '/api/products', type: :api do
	describe '#index' do
		before { get api_products_path }

		it { last_response.status.should eq 200 }

		it 'should return 10 products' do
			products = JSON.parse last_response.body
			products.count.should eq 10
		end
	end
end