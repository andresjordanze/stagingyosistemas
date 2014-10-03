 function obtener_conectados()
    {
       $.get('/sessions/obtener_conectados/'+document.getElementById('current_user').value, function(response){          
            response=response.replace(/\&quot;/g, '"');
            var conectados=JSON.parse(response);
            document.getElementById('usuarios_conectados').innerHTML="";
            for(var i=0; i<conectados.length;i++)
            {
              document.getElementById('usuarios_conectados').innerHTML+="<li class='list-group-item' onclick='showChat(\""+conectados[i].nombre_usuario+"\",\""+conectados[i].id+"\");' style='cursor:pointer;' onmouseover='this.style.background=\"#F7F7F7\";' onmouseout='this.style.background=\"white\";' ><a><img src='/assets/conected.png' /><b> "+conectados[i].nombre_usuario+"</b></a></li>";
            }
          });
       setTimeout(obtener_conectados,10000);
    }