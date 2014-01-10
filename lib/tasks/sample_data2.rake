namespace :db do
  desc "Fill database with sample data"
  task populate2: :environment do
    User.create!(name: "Harrison Chen",
                 email: "harrisonxchen@gmail.com",
                 password: "dummys",
                 password_confirmation: "dummys",
                 admin: true)
  end
end