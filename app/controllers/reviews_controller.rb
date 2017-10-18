class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create # REFACTOR FLASH MESSAGES IF NEEDED
    @review = Review.new(reviews_params)

    if @review
      flash[:success] = :success
      flash[:message] = "Thank you for reviewing this product!"
      redirect_to product_path(@review.product.id) # Product View Page
    else
      flash[:success] = :failure
      flash[:message] = "Could not submit review. Please try again!"
      flash[:errors] = @review.errors.messages
      render :new, status: :bad_request
    end
  end


  private

  def reviews_params
    params.require(:review).permit(:description, :rating)
  end

end
