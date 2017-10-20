require 'csv'

REVIEW_FILE = Rails.root.join('db','seed_data','review.csv')
puts "Loading raw media data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.review = row['review']
  review.rating = row['rating']
  review.product_id = row['product']
  puts "Created review: #{review.inspect}"
  successful = review.save
  if !successful
    review_failures << review
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save"


MERCHANT_FILE = Rails.root.join('db','seed_data','merchant.csv')
puts "Loading raw media data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
  puts "Created merchant: #{merchant.inspect}"
  successful = merchant.save
  if !successful
    merchant_failures << merchant
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchants failed to save"



CATEGORY_FILE = Rails.root.join('db','seed_data','categories.csv')
puts "Loading raw media data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['username']
  puts "Created category: #{category.inspect}"
  successful = category.save
  if !successful
    category_failures << category
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"
