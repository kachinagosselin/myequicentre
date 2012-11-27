# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :horse do
    name "MyString"
    breed "MyString"
    gender "MyString"
    age 1
    height "9.99"
    text_description "MyText"
    price "9.99"
  end
end
