# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evento do
    nombre "MyString"
    detalle "MyString"
    lugar "MyString"
    fecha "2013-12-01"
    estado false
  end
end
