require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

  # test "the truth" do
  #   assert true
  # end

  test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive and <= 100" do
		product = Product.new(
			:title => "My Book Title" ,
			:description => "yyy" ,
			:image_url => "zzz.jpg"
		)

		product.price = -1
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01" ,
		product.errors[:price].join('; ' )

		product.price = 0
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01" ,
		product.errors[:price].join('; ' )

		product.price = 1
		assert product.valid?

		product.price = 1000
		assert product.valid?, 'must be less than or equal to 1000'
	end

	test "product title must be at least 10 characters" do
		product = Product.new(
			:description => "yyy" ,
			:image_url => "zzz.jpg",
			:price => 2.0
		)

		product.title = "Hello"
		assert product.invalid?, "title must be at least 10 characters"
	end

	def new_product(image_url)
		Product.new(
			:title => "My Book Title" ,
			:description => "yyy" ,
			:price => 1,
			:image_url => image_url
		)
	end

	def add_new_product(image_url)
		Product.create(
			:title => "My Book Title" ,
			:description => "yyy" ,
			:price => 1,
			:image_url => image_url
		)
	end

	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gif.more }

		ok.each do |name|
			assert new_product(name).valid?, " #{name} shouldn't be invalid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, " #{name} shouldn't be valid"
		end

		assert add_new_product('unique.jpg').valid?, 'unique.jpg should be valid'
		assert add_new_product('unique.jpg').invalid?, 'unique.jpg is already taken'
	end

	test "product is not valid without a unique title" do
		product = Product.new(
			:title => products(:ruby).title,
			:description => "yyy" ,
			:price => 1,
			:image_url => "fred.gif"
		)
		assert !product.save
		assert_equal "has already been taken" , product.errors[:title].join('; ' )
		end
end
