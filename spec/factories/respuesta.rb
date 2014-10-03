# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :respuestum, :class => 'Respuesta' do
    pregunta nil
    texto "MyString"
    respuesta_del_usuario "MyString"
  end
end
