namespace :plan do
  desc "create plan"
  task create: :environment do
    2.times do |n|
      Plan.create(
        name: "#{n + 1}000円プラン",
        amount: "#{n + 1}000"
      )
    end
  end
end
