require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name "John"
    last_name "Smith"
    phone_number "123-456-7810"
    password "Password"
    password_confirmation "Password"
    admin false
  end
end
