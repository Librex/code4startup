namespace :project do
  desc "create project"
  task create: :environment do
    plan_name = ["css", "html"]
    plan_name.each do |name|
      Project.create(
        name: name,
        content: "テスト",
        free_flg: 2
      )
    end
  end
end
