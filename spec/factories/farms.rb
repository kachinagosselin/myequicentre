# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :farm do
    name "MyString"
    description "MyText"
    phone 1
    website "MyString"
    rate 1
    capacity 1
    city "MyString"
    state "MyString"
    user nil
  end
end
