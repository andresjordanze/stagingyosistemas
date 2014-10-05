// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//require ajaxify_rails
// anadir = al final de la linea de arriba para que funcione el ajaxify
//Ajaxify.init
  //   scroll_to_top: false

function mostrar_ocultar_opcion(elemento, valor)
 {
    var valueSelected=valor;
    var padre=$(elemento).closest('.panel-body');
    if(valueSelected=="Texto Libre")
     {
        var div_respuestas=padre.find(".respuestas"); 
        div_respuestas.find('.fields').remove();
        padre.find(".semilla").hide();
     }
     else if(valueSelected=="Opcion Multiple")
     {
        var div_respuestas=padre.find(".respuestas"); 
        div_respuestas.find('.fields').remove();
        padre.find(".semilla").show();
     }
 };


 function mostrar_nombre_archivo(elemento)
 {
    
    $(elemento).parent().find("#showfiles").val($(elemento).val().split('\\').pop());

 }

 function mostrar_nombre_archivo_dos(elemento)
 {
    
    $(elemento).parent().find(".file").click();

 }