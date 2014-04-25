# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stamp_credit_card, :class => 'CreditCard' do
    id 1
    card_number 1
    name "MyString"
    exp_date_month 1
    exp_date_year 1
  end
end
