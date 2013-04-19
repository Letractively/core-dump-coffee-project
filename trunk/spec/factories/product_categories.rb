# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_category, :class => 'ProductCategories' do
    category_id 1
    name "MyString"
  end
end
