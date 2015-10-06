require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Rawkstar#{n}" }
    sequence(:email) {|n| "santa#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :group do
    name "Abacadabera! It's a group!"
    description "the best group yet!"
    user
  end

end
