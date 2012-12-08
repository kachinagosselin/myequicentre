# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :saved_horse do
    horse_id "9.99"
    saved false
  end
end
