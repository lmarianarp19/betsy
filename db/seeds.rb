# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

REVIEW_FILE = Rails.root.join('db', 'review.csv')
puts "Loading raw media data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.review = row['review']
  review.rating = row['rating']
  review.prodcut_id = row['product_id']
  puts "Created review: #{review.inspect}"
  successful = review.save
  if !successful
    review_failures << review
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save"
