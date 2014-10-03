# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tarea do
    titulo "Tarea de Prueba"
    descripcion "Una tarea de prueba no muy larga para que no se resuma"
    fecha_entrega "2014-10-13"
    hora_entrega "10:00 PM"
  end

  factory :tarea2, class: Tarea do
    titulo "Tarea de Prueba 2"
    descripcion "Una tarea de prueba no muy larga para que no se resuma"
    fecha_entrega "2013-10-13"
    hora_entrega "10:00 PM"
  end
  factory :tarea3, class: Tarea do
    titulo "Tarea de Prueba 3"
    descripcion "Una tarea de prueba no muy larga para que no se resuma"
    fecha_entrega "2013-10-13"
    hora_entrega "10:00 PM"
  end
end
