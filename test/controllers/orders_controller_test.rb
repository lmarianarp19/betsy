require "test_helper"

describe OrdersController do
  describe "show" do
    it "succeeds for an order that exists" do
        order_id = Order.first.id
        get order_path(order_id)
        must_respond_with :success
      end

    it "returns not_found for a book that doens't exists" do
        order_id = Order.last.id + 1
        get order_path(order_id)
        must_respond_with :not_found
      end
  end

 describe "create" do
       it "adds the order to the DB id data is valid" do
        # Arrange
        order_data = {
          order: {
            status: "pending"
            #payment_id: Payment.first.id
          }
        }
        start_order_count = Order.count
        Order.create(order_data[:order]).must_be :valid?
        #post orders_path, params: order_data
      end
    end
  end #first describe

  #       # Test data should result in a valid book, otherwise
  #       # the test is broken
  #       Book.new(book_data[:book]).must_be :valid?
  #
  #       start_book_count = Book.count
  #
  #       # Act
  #       post books_path, params: book_data
  #
  #       # Assert
  #       must_respond_with :redirect
  #       must_redirect_to books_path
  #
  #       Book.count.must_equal start_book_count + 1
  #     end
  #
  # end


# describe "create" do
  #   it "adds the book to the DB and redirects when the book data is valid" do
  #     # Arrange
  #     book_data = {
  #       book: {
  #         title: "Test book",
  #         author_id: Author.first.id
  #       }
  #     }
  #     # Test data should result in a valid book, otherwise
  #     # the test is broken
  #     Book.new(book_data[:book]).must_be :valid?
  #
  #     start_book_count = Book.count
  #
  #     # Act
  #     post books_path, params: book_data
  #
  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to books_path
  #
  #     Book.count.must_equal start_book_count + 1
  #   end
  #
  #   it "sends bad_request when the book data is bogus" do
  #     # Arrange
  #     invalid_book_data = {
  #       book: {
  #         # NO TITLE!!!
  #         author_id: Author.first.id
  #       }
  #     }
  #     # Double check the data is truly invalid
  #     Book.new(invalid_book_data[:book]).wont_be :valid?
  #
  #     start_book_count = Book.count
  #
  #     # Act
  #     post books_path, params: invalid_book_data
  #
  #     # Assert
  #     must_respond_with :bad_request
  #     # Vanilla rails doesn't provide any way to do this
  #     # assert_template :new
  #     Book.count.must_equal start_book_count
  #   end
  # end
