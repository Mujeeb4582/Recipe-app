FactoryBot.define do
  factory :user do
    id { Faker::Number.number(digits: 5) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name }
  end
end
