require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def add_new_product(cart, product)
  	cart.add_product(product.id, product.price).save!
  end

  test 'cart should create a new line item when adding a new product' do
    cart = Cart.create

  	add_new_product(cart, products(:ruby))
  	assert_equal 1, cart.line_items.count, 'line_items should be 1'
    assert_equal products(:ruby).price, cart.line_items.first.price

  	add_new_product(cart, products(:rails))
  	assert_equal 2, cart.line_items.count, 'line_items should be 2'
    assert_equal products(:rails).price, cart.line_items.last.price
  end

  test 'cart should update existing line_item when adding existing product' do
    cart = Cart.create
    add_new_product(cart, products(:ruby))
    add_new_product(cart, products(:ruby))
    assert_equal 1, cart.line_items.count
    assert_equal products(:ruby).price, cart.line_items.first.price
  end
end
