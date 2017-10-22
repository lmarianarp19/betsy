class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create # REFACTOR FLASH MESSAGES IF NEEDED
    @review = Review.new(reviews_params)
    @review.product_id = params[:product_id]

    if @review.save
      flash[:status] = :success
      flash[:message] = "Thank you for reviewing this product!"
      redirect_to product_path(params[:product_id]) # Back to the product show page
    else
      flash[:status] = :failure
      flash[:message] = "Could not submit review. Please try again!"
      flash[:errors] = @review.errors.messages
      render :new, status: :bad_request
    end
  end


  private

  def reviews_params
    params.require(:review).permit(:review, :rating)
  end

end
