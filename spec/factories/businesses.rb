# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business do
    name "MyString"
    description "MyText"
    phone 1
    website "MyString"
    city "MyString"
    state "MyString"
    user nil
  end
end
