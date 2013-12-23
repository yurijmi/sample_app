namespace :db do
  desc 'Fill database with sample data'

  task populate: :environment do
    print 'Creating Users'

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

    print "\nCreating microposts"

    users = User.all(limit: 6)
    50.times do |n|
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }

      print '.'
    end

    print "\nDone!\n\n"
    print 'Finished all sample_data tasks!'
  end
end