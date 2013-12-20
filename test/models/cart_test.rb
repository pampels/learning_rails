require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def add_new_product(product)
  	cart = Cart.create
  	cart.add_product(product.id, product.price)
  	cart
  end

  test 'cart should be created' do
  	cart = Cart.create
  	cart.add_product(products(:ruby).id, products(:ruby).price).save!
    assert_equal 3, LineItem.count
	end

  test 'cart should create a new line item when adding a new product' do
  	# cart = add_new_product(products(:ruby))
  	# assert_equal 1, cart.line_items.count

  	# cart = add_new_product(products(:one))
  	# assert_equal 2, cart.line_items.count
  end
end
