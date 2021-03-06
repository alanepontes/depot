require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    fixtures :products

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

    test "url da imagem" do
        ok = %w{alane.gif zuzu.jpg alfredo.png teste.PNG}
        bad = %w{alane.git alane.gif.more alane.png.git}

        ok.each do |image_url|
            assert new_product(image_url).valid?, "#{image_url} should be valid"
        end

        bad.each do |image_url|
            assert new_product(image_url).invalid?, "#{image_url} shouldn't be valid"
        end


    end

    test "produto não é válido sem título único" do
        product = Product.new(
                title:          products(:my_fixture_book).title,
                description:    'teste',
                image_url:      'teste.jpg',
                price:          10
            )

        assert product.invalid?
        assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
    end

    test "o titulo deve ter 10 ou mais caracteres" do
        product = products(:my_fixture_book)

        if product.title.length >= 10
            assert true
        else
            assert false
        end
    end

    def new_product(image_url)
        product = Product.new(
            title: 'TesteRails',
            description: 'preco_do_produo',
            image_url: image_url,
            price: 10
        )
    end


end
