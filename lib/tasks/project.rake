namespace :project do
  desc "create project"
  task create: :environment do
    plan_name = ["css", "html", "javascript", "ruby_on_rails", "python", "java"]
    plan_name.each do |name|
      Project.create(
        name: name,
        content: "テスト",
        free_flg: 2
      )
    end
  end
  desc "free project"
  task free_create: :environment do
    plan_name = ["freeなやつ12", "freeやつ23"]
    plan_name.each do |name|
      Project.create(
        name: name,
        content: "無料なやつですよ",
        free_flg: 1
      )
    end
  end
end
