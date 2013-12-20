class Product < ActiveRecord::Base
	default_scope :order => 'title'
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01, :less_than_or_equal_to => 1000}
	validates :title, :uniqueness => true, :length => {minimum: 10, too_short: "is too short (Minimum of 10 characters)"}
	validates :image_url, :uniqueness => true, :format => {
		:with => %r{\.(gif|jpg|png)\z}i,
		:message => 'must be a URL for GIF, JPG or PNG image.'
	}

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors.add(:base, 'Line Items present' )
			return false
		end
	end
end
