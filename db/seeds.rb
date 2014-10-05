# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
publico = Grupo.create(nombre: 'Publico', descripcion: 'todos deben tener ingreso a temas publicos', estado: false, llave: "publico")
docente = Usuario.create(nombre_usuario: "docente", nombre: "docente", apellido: "seed", contrasenia: "123456", correo: "docente@gmail.com", activa: true, rol: "Docente")
administrador  = Usuario.create(nombre_usuario: "administrador", nombre: "administrador", apellido: "seed", contrasenia: "123456", correo: "administrador@gmail.com", activa: true, rol: "Administrador")
estudiante = Usuario.create(nombre_usuario: "estudiante", nombre: "estudiante", apellido: "seed", contrasenia: "123456", correo: "estudiante@gmail.com", activa: true, rol: "Estudiante")
estudiante1 = Usuario.create(nombre_usuario: "estudiante1", nombre: "estudiante1", apellido: "seed", contrasenia: "123456", correo: "estudiante1@gmail.com", activa: true, rol: "Estudiante1")
url = Url.create(direccion: "staging-yosistemas2014.herokuapp.com")

#evento = Evento.create(nombre: 'Evento 1', detalle: 'Ninguno', lugar: 'Cochabamba', fecha: '10/10/2014', estado: true )

#a = Usuario.create(nombre_usuario: "estudiante", nombre: "Nelson", apellido: "Araoz", contrasenia: "509e0895bd82e3315e79018a6ce02181", correo: "nelsonaraoz@ymail.com", activa: true, rol: "Estudiante")