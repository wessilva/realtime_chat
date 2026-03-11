# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

names = ["Jane", "Bob", "Beast"]

# Create 3 Users
3.times do |i|    
    created_user = User.find_or_create_by!(email: "user#{i+2}@com") do |u|
        u.name = names[i]
        u.password = "password"
        u.password_confirmation = "password"
    end

    puts "Created User: #{names[i]}"
    User.first.added_users << created_user
    puts "User #{names[i]} has been added to Wesley"
end

# Create 3 Groups
3.times do |i|
    created_group = Group.create!(
        name: "Group#{i}",
        admin_id: 1 # This is user_id of Arcadia
    )
    puts "Created Group: Group#{i}"
    User.first.added_groups<< created_group
    puts "Group#{i} has been added to Wesley"
end
