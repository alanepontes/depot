require 'test_helper'

class ProductTest < ActiveSupport::TestCase
   test "atributos do produto não podem ser vazios" do
        product = Product.new
        assert product.invalid?
        assert product.errors[:title].any?
        assert product.errors[:description].any?
        assert product.errors[:price].any?
        assert product.errors[:image_url].any?
    end

    test "O preco do produto deve ser positivo" do
        product = Product.new(
            title: 'TesteRails',
            description: 'preco_do_produo',
            image_url: 'test.jpg'
        )

        product.price = -1
        assert product.invalid?
        assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

        product.price = 0
        assert product.invalid?
        assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

        product.price = 1
        assert product.valid?

    end


end
