namespace :user do
  desc 'create user'
  task create: :environment do
    user = User.new(
      email: 'test@example.com',
      password: 'test1234',
      name: 'test太郎'
    )
    user.save(validate: false)
  end
end
