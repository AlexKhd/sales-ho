FactoryBot.define do
  factory :user do
    name                        { Faker::Name.first_name }
    sequence(:email)            { |n| "person#{n}@example.com" }
    #email                       { 'example@example.com' }
    confirmed_at                { 1.day.ago }
    password                    { 'tester' }
    password_confirmation       { 'tester' }
    # userid creates in model callback

    trait :admin do
      sequence(:name)             { |n| "adm rspec factory #{User.last ? User.last.id + 1 : 1}" }
      sequence(:email)            { |n| "admin#{n}@example.com" }
      password                    { 'admin321' }
      password_confirmation       { 'admin321' }
      blocked                     { false }
      after(:create)              { |admin| admin.add_role(:admin) }
    end

    trait :operator do
      sequence(:name)             { |n| "operator rspec factory #{User.last ? User.last.id + 1 : 1}" }
      sequence(:email)            { |n| "operator#{n}@example.com" }
      password                    { 'tester' }
      blocked                     { false }
      after(:create)              { |operator| operator.add_role(:operator) }
    end
  end
end
