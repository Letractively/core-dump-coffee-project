# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category, :class => 'Categories' do
    category_id 1
    name "MyString"
  end
end
