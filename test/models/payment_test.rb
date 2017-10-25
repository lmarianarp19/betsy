require "test_helper"

describe Payment do

  describe "validations" do
    let(:example_payment) { payments(:payment_one) }
    describe "presence" do
      it "requires a name" do
        example_payment.name = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :name
      end

      it "requires an email" do
        example_payment.email = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :email
      end

      it "requires a mailing address" do
        example_payment.mailing_address = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :mailing_address
      end

      it "requires a cc_name" do
        example_payment.cc_name = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :cc_name
      end

      it "requires a cc expiration date" do
        example_payment.cc_expiration = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :cc_expiration
      end

      it "requires a cc number" do
        example_payment.cc_number = nil
        example_payment.valid?.must_equal false
        example_payment.errors.messages.must_include :cc_number
      end


    end
    describe "format of ccv and cc number" do
      it "does not accept a ccv with greater than or less than 3 numbers" do
        example_payment.cc_ccv = 12
        example_payment.valid?.must_equal false

        example_payment.cc_ccv = 1234
        example_payment.valid?.must_equal false

        example_payment.cc_ccv = 123
        example_payment.valid?.must_equal true
      end

      it "does not accept a credit card numer with less than 13 digits and greater than 16 digits" do
        twelve = 12.times.map{rand(10)}.join
        example_payment.cc_number = twelve
        example_payment.valid?.must_equal false

        seventeen = 17.times.map{rand(10)}.join
        example_payment.cc_number = seventeen
        example_payment.valid?.must_equal false

        thirteen = 13.times.map{rand(10)}.join
        example_payment.cc_number = thirteen
        example_payment.valid?.must_equal true
      end
    end
  end

end
