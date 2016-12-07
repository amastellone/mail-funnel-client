require 'rails_helper'

RSpec.describe Shop, type: :model do

  #Shop should not be valid without setting any attributes
  it 'is not valid without any populated attributes' do

    shop = Shop.new

    expect(shop).to_not be_valid

  end

  #Shop should not be valid without shopify_token attribute
  it 'is not valid without shopify_token attribute' do

    shop = Shop.new(shopify_domain: 'Any Domain')

    expect(shop).to_not be_valid

  end

  #Shop should not be valid without shopify_domain attribute
  it 'is not valid without shopify_domain attribute' do

    shop = Shop.new(shopify_token: 'Any Token')

    expect(shop).to_not be_valid

  end

  #Shop should be valid once you set both the shopify_domain and shopify_token attributes
  it 'is valid with shopify_domain and shopify_token attributes' do

    shop = Shop.new(shopify_domain: 'Any Domain', shopify_token: 'Any Token')

    expect(shop).to be_valid
  end

  #Shop should valid with shopify attributes set but no timestamps set
  it 'is valid with shopify attributes but no timestamps' do

    shop = Shop.new(shopify_domain: 'Any Domain', shopify_token: 'Any Token', created_at: nil, updated_at: nil)

    expect(shop).to be_valid

  end

  #Shop should be valid with shopify attributes then once changed to null should not be
  it 'is valid upon correct creation then not valid once shopify domain is null' do

    shop = Shop.new(shopify_domain: 'Any Domain', shopify_token: 'Any Token')

    expect(shop).to be_valid

    #change shopify attributes to null
    shop.shopify_domain = nil
    shop.shopify_token = nil

    expect(shop).to_not be_valid

  end

end
