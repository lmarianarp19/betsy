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
      # must_redirect_to product_path(review_data[:review][:product_id])
      # Review.count.must_equal before_count + 1
    end

  end

end
