require "test_helper"

describe MainController do
  describe "#index" do
    it "must return success if the root path is requested" do
      get root_path

      must_respond_with :success
    end
  end
end
