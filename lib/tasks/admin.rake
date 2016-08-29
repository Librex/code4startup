namespace :admin do
  desc 'create admin'
  task create: :environment do
    user = AdminUser.new(
      email: 'admin@example.com',
      password: 'test123',
    )
    user.save(validate: false)
  end
end
