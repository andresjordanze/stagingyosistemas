# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tema_comentario do
    cuerpo "comentario, importante"
    tema_id 1
    usuario_id 1
  end
end
