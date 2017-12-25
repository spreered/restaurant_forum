namespace :dev do
  task fake_restaurant: :environment do 
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!( name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,        
        category: Category.all.sample
      )
    end

    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do 
    20.times do |i|
      User.create!(
        email: FFaker::Internet.email,
        password: "password"
      )
    end
    puts "have create fake users"
  end

  task fake_comment: :environment do 
    restaurants = Restaurant.all
    restaurants.each do |restaurant|
      3.times do |i|
        Comment.create!(
          content: FFaker::BaconIpsum.sentence,
          user_id: User.all.sample.id,
          restaurant_id: restaurant.id
        )
      end
    end

    puts "create fake comments"
  end

  task fake_name: :environment do 
    # create fake name if name is nil
    users = User.all
    users.each do |user|
      if user.name == nil
        user.update_attribute(:name,FFaker::Name.name)
      end
    end

    puts "create fake name of each user"
  end

end
