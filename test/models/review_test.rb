require "test_helper"

describe Review do
  let(:review) { reviews(:review_one) }

  describe "#valid?" do

    it "should return false without a rating" do
      review.rating = nil
      review.valid?.must_equal false
    end

    it "should return false if rating is not between 1 and 5" do
      review.rating = 6
      review.valid?.must_equal false
    end

  end #describe



  describe "#product" do

    it "should return the associated product" do
      review.product.must_equal products(:second_product)
    end
  end

end  #descibe
