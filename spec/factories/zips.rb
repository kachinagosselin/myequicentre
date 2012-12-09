# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zip do
    code "MyString"
    city "MyString"
    state "MyString"
    lat "9.99"
    lon "9.99"
  end
end
