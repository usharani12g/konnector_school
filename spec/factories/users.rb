FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "test1234" }
    role { :student }

    association :school

    trait :admin do
      role { :admin }
      school { nil }
    end

    trait :school_admin do
      role { :school_admin }
    end

    trait :student do
      role { :student }
    end
  end
end
