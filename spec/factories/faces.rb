FactoryBot.define do
  factory :face do
    title                        { Faker::Company.name }
    shorttitle                   { Faker::Company.name }
    ftype                        { 1 }
    address                      { Faker::Address.street_address }
    active                       { true }
    description                  { Faker::Lorem.sentence }
    rut                          { Faker::ChileRut.full_rut }

    after(:build) do |f|
        f.set_fid
    end

    trait :server_hq do
      title                        { "HQ" }
      shorttitle                   { "HQ" }
      ftype                        { 20 }
      description                  { "HQ" }
      fid                          { 555 }
      dist_id                      { 555 }
      ownerdist_id                 { 555 }
    end

    trait :server_dist do
      title                        { "Dist 1" }
      shorttitle                   { "Dist 1" }
      ftype                        { 16 }
      description                  { "HQ" }
      fid                          { 1 }
      dist_id                      { 1 }
      ownerdist_id                 { 555 }
    end
  end
end
