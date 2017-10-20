require "test_helper"

describe ReviewsController do
  describe "new" do
    it "returns success when making a new review" do
      get new_review_path

      must_respond_with :success
    end
  end

  #TODO: Think of a false case for new

  describe "create" do
    it "returns success when saving a review" do
      before_count = Review.count

      review_data = {
        review: {
          review: "This is another review that will be created",
          rating: 1,
          product_id: Product.first.id
        }
      }

      Review.new(review_data[:review]).must_be :valid?

      post reviews_path, params: review_data
      #
      must_respond_with :redirect
      must_redirect_to product_path(review_data[:review][:product_id])
<<<<<<< HEAD
      # must_redirect_to product_path(review_data[:review][:product_id])
      # Review.count.must_equal before_count + 1
=======
      Review.count.must_equal before_count + 1
    end

    it "sends bad_request when the review data is bogus" do
      # Arrange
      invalid_review_data = {
        review: {
          #invalid rating, rating should be between 0 and 5
          rating: 15
          #product_id: Product.first.id
        }
      }
      # Double check the data is truly invalid
      Review.new(invalid_review_data[:review]).wont_be :valid?

      start_review_count = Review.count

      # Act
    post reviews_path, params: invalid_review_data

      # Assert
    must_respond_with :bad_request
      # Vanilla rails doesn't provide any way to do this
       #assert_template :new
    Review.count.must_equal start_review_count
>>>>>>> e20ac59a7370b100bec2948958f71411d6b626d6
    end

  end

end
