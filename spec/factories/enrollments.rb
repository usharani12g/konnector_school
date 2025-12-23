FactoryBot.define do
  factory :enrollment do
    association :user, factory: [:user, :student]
    association :batch
    status { "pending" }
  end
end