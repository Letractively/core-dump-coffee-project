# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product, :class => 'Products' do
    category_id 1
    name "MyString"
    imageurl "MyString"
    price 1
    description "MyString"
  end
end
