# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :preguntum, :class => 'Pregunta' do
    cuestionario nil
    texto "MyString"
    tipo "MyString"
  end
end
