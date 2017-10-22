class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    unless @category
      head :not_found
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end
end
