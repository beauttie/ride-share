########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

# The first layer is the driver's ID, and nested in that layer
# is a list of rides. Each list in that second layer corresponds
# to a date (the second layer has a different layer within it),
# and given that multiple rides can occur in a day, we have
# another layer that lists the cost, rider's ID, and rating
# for each ride (these three layers are next to each other).

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

# The first layer is a hash with DRIVER_ID as the keys.
# The second layer is an array of rides in chronological order.
# The third layer is a hash listing the characteristics of
# the ride(s) in a single day (DATE, COST, RIDER_ID, RATING).
# The fourth layer consists of arrays for COST, RIDER_ID, and RATING
# where the element at each index corresponds to a characteristic
# of a single ride on a given day.

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

drivers_data = {
    "DR0001" => [
        {
            date: "3rd Feb 2016",
            cost: [10, 30],
            rider_id: ["RD0003", "RD0015"],
            rating: [3, 4]
        },
        {
            date: "5th Feb 2016",
            cost: [45],
            rider_id: ["RD0003"],
            rating: [2]
        }
    ],
    "DR0002" => [
        {
            date: "3rd Feb 2016",
            cost: [25],
            rider_id: ["RD0073"],
            rating: [5]
        },
        {
            date: "4th Feb 2016",
            cost: [15],
            rider_id: ["RD0013"],
            rating: [1]
        },
        {
            date: "5th Feb 2016",
            cost: [35],
            rider_id: ["RD0066"],
            rating: [3]
        }
    ],
    "DR0003" => [
        {
            date: "4th Feb 2016",
            cost: [5],
            rider_id: ["RD0066"],
            rating: [5]
        },
        {
            date: "5th Feb 2016",
            cost: [50],
            rider_id: ["RD0003"],
            rating: [2]
        }
    ],
    "DR0004" => [
        {
            date: "3rd Feb 2016",
            cost: [5],
            rider_id: ["RD0022"],
            rating: [5]
        },
        {
            date: "4th Feb 2016",
            cost: [10],
            rider_id: ["RD0022"],
            rating: [4]
        },
        {
            date: "5th Feb 2016",
            cost: [20],
            rider_id: ["RD0073"],
            rating: [5]
        }
    ]
}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver

drivers_rides = drivers_data.map do |driver_id, rides|
  num_rides = 0
  earnings = 0
  sum_rating = 0
  rides.each do |ride|
    num_rides += ride[:rider_id].length

    ride[:cost].each { |ride_cost| earnings += ride_cost }
    ride[:rating].each { |ride_rating| sum_rating += ride_rating }
  end

  {
      driver_id => {
          num_rides: num_rides,
          earnings: earnings,
          avg_rating: sum_rating.to_f / num_rides
      }
  }
end

# map outputs an array
# p drivers_rides

drivers_rides.each do |nested_hash|
  nested_hash.each do |driver_id, hash|
    puts "Driver #{driver_id} has given #{hash[:num_rides]} rides, earned $#{hash[:earnings]}, and has an average rating of #{hash[:avg_rating]} stars."
  end
end

# - Which driver made the most money?
# - Which driver has the highest average rating?

def flatten_by(array_of_nested_hashes, symbol)
  data_subset = {}

  array_of_nested_hashes.each do |nested_hash|
    nested_hash.each do |key, hash|
      data_subset[key] = hash[symbol]
    end
  end

  return data_subset
end

earnings_hash = flatten_by(drivers_rides, :earnings)
avg_rating_hash = flatten_by(drivers_rides, :avg_rating)

# p earnings_hash
# p avg_rating_hash

puts "Driver #{earnings_hash.key(earnings_hash.values.max)} made the most money with a total of $#{earnings_hash.values.max}."

puts "Driver #{avg_rating_hash.key(avg_rating_hash.values.max)} has the highest average rating of #{avg_rating_hash.values.max} stars."
