namespace :db do
  desc 'Fill database with sample data'

  task populate: :environment do
    print 'Filling database with sample data'
    print "\n\n"
    make_users
    print "\n"
    make_microposts
    print "\n"
    make_relationships
    print "\n\n"
    print 'Done!'
  end
end

def make_users
  print 'Creating users'

  admin = User.create!(name: 'Yurijmi',
                       email: 'me@yurijmi.ru',
                       password: 'foobar',
                       password_confirmation: 'foobar')
  admin.toggle!(:admin)
  print '.'

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@yurijmi.ru"
    password = 'password'

    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)

    print '.'
  end
end

def make_microposts
  print 'Creating microposts'

  users = User.all(limit: 6)
  50.times do |n|
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }

    print '.'
  end
end

def make_relationships
  print 'Creating relationships'

  users = User.all
  user  = users.first

  followed_users = users[2..50]
  followers      = users[3..40]

  followed_users.each do |followed|
    user.follow!(followed)

    print '.'
  end

  followers.each do |follower|
    follower.follow!(user)

    print '.'
  end
end