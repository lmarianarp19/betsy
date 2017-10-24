require "test_helper"

describe CategoriesController do

  let(:category) { Category.first }
  let(:merchant) { merchants(:grace) }

  # TODO: DO WE NEED THESE/
  # describe "#index" do
  #
  #   # it "returns success if all categories are valid" do
  #   #   get categories_path
  #   #
  #   #   must_respond_with :success
  #   # end
  #   #
  #   # it "returns success if a merchant is logged in" do
  #   #   login(merchant)
  #   #
  #   #   get categories_path
  #   #
  #   #   must_respond_with :success
  #   # end
  #
  # end

  # describe "#show" do
  #   it "returns success if a category exists and is valid" do
  #     get category_path(category)
  #
  #     must_respond_with :success
  #   end
  #
  #   it "returns not_found if the category does not exist" do
  #     get category_path(Category.last.id + 1)
  #
  #     must_respond_with :not_found
  #   end
  #
  #   it "returns success if a merchant is logged in" do
  #     login(merchant)
  #
  #     get category_path(category)
  #
  #     must_respond_with :success
  #   end
  # end
end
