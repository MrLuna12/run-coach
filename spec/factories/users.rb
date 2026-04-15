FactoryBot.define do
  factory :user do
    strava_id { Faker::Number.unique.number(digits: 8).to_s }
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    profile_picture { Faker::Internet.url }
    access_token { Faker::Alphanumeric.alphanumeric(number: 40) }
    refresh_token { Faker::Alphanumeric.alphanumeric(number: 40) }
    expires_at { 1.hour.from_now.to_i }

    trait :token_expired do
      expires_at { 1.hour.ago.to_i }
    end
  end
end
