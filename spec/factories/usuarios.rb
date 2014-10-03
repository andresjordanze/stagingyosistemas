# Read about factories at https://github.com/thoughtbot/factory_girl
require 'digest/md5'

FactoryGirl.define do
  factory :usuario do
    nombre "Pedro"
    apellido "Pedregal"
    contrasenia "password"
    correo "email@email.com"
    nombre_usuario "pedrito"
    rol "Docente"
    activa true
  end

  factory :other_user, class: Usuario do
    nombre "Pedro"
    apellido "Pedregal"
    contrasenia "password2"
    correo "email2@email.com"
    nombre_usuario "pedrito1"
    rol "Docente"
    activa true
  end

  factory :other_user_estudiante, class: Usuario do
    nombre "Pedro"
    apellido "Pedregal"
    contrasenia "password2"
    correo "email2@email.com"
    nombre_usuario "pedrito2"
    rol "Estudiante"
    activa true
    end

factory :other_student, class: Usuario do
    nombre "Pedro"
    apellido "Pedregal"
    contrasenia "password"
    correo "email2@email.com"
    rol "Estudiante"
    nombre_usuario "pedrito3"
    activa true
    end



    factory :other_diferent_user, class: Usuario do
    nombre "Jarry"
    apellido "ConJ"
    contrasenia "password2"
    correo "email2@email.com"
    rol "Docente"
    nombre_usuario "jarry"
    activa false
  end

  factory :usuario_estudiante , class: Usuario do
    nombre "Pedro"
    apellido "Pedregal"
    contrasenia "password"
    correo "email666@email666.com"
    nombre_usuario "pedrito666"
    rol "Estudiante"
    activa true
  end
end