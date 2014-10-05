function send()
    {

      var para_u=document.getElementById('chat_name').innerHTML;
      var mensaje_u=document.getElementById("mensaje_sincrono").value;
      if(mensaje_u)
      {
        var usuario_id_u=document.getElementById('id_usuario_envio').value;
        $.post( "/mensajes/enviar", { para: para_u, mensaje: mensaje_u } );
        document.getElementById("mensaje_sincrono").value="";
        document.getElementById('chat_conversacion').innerHTML+="<div class='row'><div class='col-lg-12'><div class='pull-right pager' style='margin-bottom: 5px; margin-top: 0px;'><ul><li><a style='color:white;  background-color:#b81e0d;' title='"+mensaje_u+"'>"+mensaje_u+"</a></li></ul></div></div></div>";
          document.getElementById('chat_conversacion').scrollTop = 99999999;     
      }
    }
      function showChat(nombre_usuario,usuario_id)
      {
        document.getElementById('chat_conversacion').innerHTML="";
        document.getElementById('chat_name').innerHTML=nombre_usuario;
        document.getElementById("id_usuario_envio").value=usuario_id;
        $("#chat_window").addClass("in");
        $("#chat_window").show();        
         $.get('/usuarios/obtener_charla/'+usuario_id, function(response){          

            response=response.replace(/\&quot;/g, '"');
            var conversacion=JSON.parse(response)
            for(var i=0;i<conversacion.length;i++)
            {              
              if(conversacion[i].para_usuario_id!=usuario_id)
              {
                document.getElementById('chat_conversacion').innerHTML+="<div class='row'><div class='col-lg-12'><div class='pull-left pager' style='margin-bottom: 5px; margin-top: 0px;'><ul style='padding-left:0px;'><li><a style='color:black;' title='"+conversacion[i].created_at+"'>"+conversacion[i].mensaje+"</a></li></ul></div></div></div>";
              }
              else
              {


                document.getElementById('chat_conversacion').innerHTML+="<div class='row'><div class='col-lg-12'><div class='pull-right pager' style='margin-bottom: 5px; margin-top: 0px;'><ul><li><a style='color:white;  background-color:#428BCA;' title='"+conversacion[i].created_at+"'>"+conversacion[i].mensaje+"</a></li></ul></div></div></div>"; 
              }    
            } 
             document.getElementById('chat_conversacion').scrollTop = 99999999;           
          });
       
      }
      function closeChat()
      {
         $("#chat_window").removeClass("in");
         $("#chat_window").hide();
      }