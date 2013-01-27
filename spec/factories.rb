FactoryGirl.define do
  factory :user do
    name "Someone"
    email "some1@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end