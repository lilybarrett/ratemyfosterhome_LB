require 'factory_girl'

FactoryGirl.define do
  factory :User do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name "John"
    last_name "Smith"
    password "Password"
    password_confirmation "Password"
    admin false
  end
end
