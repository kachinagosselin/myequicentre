# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    to_name "MyString"
    from_name "MyString"
    title "MyString"
    content "MyText"
  end
end
