Yosistemas::Application.routes.draw do
  get "grupos/buscar_por_llave" => "grupos#buscar_por_llave", :as=>'buscar_grupo_por_llave'
  get "comment_tasks/create"
  get "comment_tasks/delete"
  get "comment_tasks/edit"
  get "temas/index"
  post 'temas/edit/:id' => 'temas#edit', :as => 'edit_tema'
  post 'sessions/create' => 'sessions#create', :as => 'loguear'
  get 'sessions/destroy' => 'sessions#destroy', :as => 'desloguear'
  get 'sessions/obtener_conectados/:usuario_id' => 'sessions#obtener_conectados', :as => 'obtener_conectados'
  post 'sessions/eliminar_conectado' => 'sessions#eliminar_conectado', :as => 'eliminar_conectado'
  get "usuarios/confirm/:pass" => "usuarios#confirm", :as => 'confirm'
  get '/agregar_url' => 'url#agregar_url'
  post '/agregar_url' => 'url#create'

  #get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  
  get "usuarios/index"
  get "usuarios/show"


  #get "usuarios/perfil/:id" => "usuarios#perfil", :as => "perfil"
  get "usuarios/new" => "usuarios#new", :as =>"register"
  get "usuarios/update_password" => "usuarios#update_password", :as=>"update_password"
  get "usuarios/edit" => "usuarios#edit", :as=>"usuario_edit"
  get "usuarios/cambiar_email" => "usuarios#cambiar_email", :as=>"usuario_cambiar_email"
  post "usuarios/edit_password" => "usuarios#edit_password", :as=> "edit_password"
  
  post "usuarios/guardar_cambio_email" => "usuarios#guardar_cambio_email", :as=> "guardar_cambio_email"
  
  get 'usuarios/password_recovered/:id_user/:id_request' => 'usuarios#recover', :as => 'recover'
  post "usuarios/password_recovered/:id_user/:id_request" => "usuarios#password_recovered", :as=> "password_recovered"
  
  get 'usuarios/comfirmar_cambio_correo/:id_user/:correo' => 'usuarios#comfirmar_cambio_correo', :as => 'comfirmar_cambio_correo'
  get 'usuarios/confirm_change_password/:id_user' => 'usuarios#confirm_change_password', :as => 'confirm_change_password'  

  post "usuarios/send_password_mail" => "usuarios#send_password_mail", :as => "send_password_mail"
  get "usuarios/send_password_mail" => "usuarios#forgot_password", :as => "forgot_password"
  get "usuarios/obtener_charla/:usuario_id" => "usuarios#obtener_charla", :as => "obtener_charla"

  get "usuarios/obtener_notificacion/:comentario_id/:usuario_id/:tema_id" => "usuarios#obtener_notificacion", :as => "obtener_notificacion"
  
  #rutas de temas
  get "temas/buscar/:grupo" => "temas#buscar", :as=>'buscar_tema'
  get "temas/editar_comentario/:id_comentario" => "temas#editar_comentario", :as  => 'editar_tema_comentario'
  post "tema_comentarios/editar/:id" => "tema_comentarios#editar", :as  => 'editar_comentario_tema'
  get "tema_comentarios/delete/:id" => "tema_comentarios#delete"
  get "temas/ordertable/:themes/:id/:var" => 'temas#ordertable', :as  => 'ordertable'
  get "temas/ordertablemine/:themes/:var" => 'temas#ordertablemine' , :as => 'ordertablemine'
  get 'temas/visible/:id' => 'temas#visible', :as => 'visible_tema'
  get 'temas/show_mine' => 'temas#show_mine', :as=>'show_mine'
  get 'temas/search_main' => 'temas#search_main', :as=>'search_main'
  get 'temas/new/:id' => 'temas#new', :as => 'tema_para_grupo'
  #get 'temas/:grupo' => 'temas#index'
  #rutas de suscripciones
  get "suscripcion_temas/create/:id" => 'suscripcion_temas#create', :as => 'suscribirse_tema'
  get "suscripcion_temas/delete/:id" => 'suscripcion_temas#delete', :as => 'rechazar_tema'
  get "subscripcion/delete/:id" => "subscripcions#delete", :as => 'borrar_suscripcion'
  post "subscripcion/notificar/:id" => 'subscripcions#notificar', :as => 'notificar'
  #rutas de grupos
  
  get 'grupos/subscripcion_grupo/:id' => 'grupos#subscripcion_grupo', :as=>'suscribirse'
  get "grupos/buscar" => "grupos#buscar", :as=>'buscar_grupo'
  get 'grupos/mis_grupos' => 'grupos#mis_grupos', :as => 'mis_grupos'
  get 'grupos/suscriptores/:id' => 'grupos#suscriptores', :as => 'suscriptores'
  get 'gruopos/detalle_usuario/:id' => 'grupos#detalle_usuario', :as => 'detalle_usuario'
  get "grupos/:id/temas"  => "temas#index", :as=> 'filtrar_temas'
  get "grupos/:id/temas-y-tareas"  => "temas_y_tareas#index", :as=> 'temas_y_tareas'
  get 'grupos/invitacion_grupo/:id' => 'grupos#invitacion_grupo', :as => 'invitacion_grupo'
  post 'grupos/enviar_invitaciones/:id' => 'grupos#enviar_invitaciones', :as => 'enviar_invitaciones'
  get 'grupos/:id/editar_grupo' => 'grupos#edit', :as => 'edit' 
        
  get 'grupos/deshabilitar_grupo/:id' => 'grupos#deshabilitar_grupo'
  get 'grupos/habilitar_grupo/:id' => 'grupos#habilitar_grupo'

  #rutas de tareas
  get 'tareas/new/:id' => 'tareas#new', :as => 'tarea_para_grupo'
  get 'tareas/eliminar/:id' => 'tareas#eliminar'
  get 'tareas/edit/:id' => 'tareas#edit'
  get 'tareas/ver_tareas' => 'tareas#ver_tareas'
  post 'tareas/guardar_tarea_a_partir_de_otra/:id_tarea_antigua'=>'tareas#guardar_tarea_a_partir_de_otra',:as =>'guardar_tarea_a_partir_de_otra'
  get '/tareas/cargar_datos_tarea/:id/:id_tarea' => 'tareas#cargar_datos_tarea'
  get 'grupos/:grupo/tareas' => 'tareas#index', :as => 'tareas_index'
  get 'tareas/responder_tarea/:id' => 'tareas#responder_tarea', :as =>'responder_tareas'
  post 'tareas/responder_tarea/:id' => 'tareas#responder_tarea_crear', :as =>'responder_tarea_crear'
  get 'tareas/mostrar_respuesta_tarea/:id' => 'tareas#mostrar_respuesta_tarea', :as =>'mostrar_respuesta_tarea'
  post 'tareas/mostrar_respuesta_tarea/:id' => 'tareas#mostrar_respuesta_tarea_crear', :as =>'mostrar_respuesta_tarea_crear'
  post "usuarios/update_user/:id"=>"usuarios#update"
  get "tareas/editar_comentario/:id_comentario" => "tareas#editar_comentario"
  post "tarea_comentarios/editar/:id" => "tarea_comentarios#editar", :as  => 'editar_comentario_tarea'
  get "tarea_comentarios/delete/:id" => "tarea_comentarios#delete"
  #Cuestionarios
  get "cuestionarios/nuevo_cuestionario/:id" => "cuestionarios#nuevo_cuestionario", :as => 'nuevo_cuestionario'
  get "cuestionarios/cuestionarios_de_grupo_index/:id" => "cuestionarios#cuestionarios_de_grupo_index", :as => 'cuestionarios_de_grupo_index'
  get "cuestionarios/delete/:id" => "cuestionarios#delete", :as => 'borrar_cuestionario'
  get "cuestionarios/editar_cuestionario/:id" => "cuestionarios#editar_cuestionario", :as => 'editar_cuestionario'
  get "cuestionarios/usar_plantilla/:id" => "cuestionarios#usar_plantilla"
  get "cuestionarios/ver_cuestionarios_usuarios/:id_cuestionario"=> "cuestionarios#ver_cuestionarios_usuarios", :as => 'ver_cuestionarios_usuarios'
  get "cuestionarios/ver_cuestionarios_usuarios/cargar_respuestas/:id_usuario/:id_cuestionario"=> "cuestionarios#cargar_respuestas", :as => 'cargar_respuestas'
  get "cuestionarios/ver_resultados_usuarios/:id_cuestionario"=> "cuestionarios#ver_resultados_usuarios", :as => 'ver_resultados_usuarios'
  get "cuestionarios/ver_resumen/:id_cuestionario" => "cuestionarios#ver_resumen", :as => 'ver_resumen'
  get "cuestionarios/ver_resultado/:id_cuestionario" => "cuestionarios#ver_resultado", :as => 'ver_resultado'
  post "cuestionario/calificar" => "cuestionarios#calificar", :as => "calificar"
  #mensajes
  post "mensajes/enviar" => "mensajes#enviar", as: 'enviar_mensaje'
  #respuesta_usuarios
  get "respuesta_usuarios/nuevo/:id" => "respuesta_usuarios#nuevo", :as => "nuevo"
  post "respuesta_usuarios/crear" => "respuesta_usuarios#crear", :as => "crear"
  post "respuesta_usuarios/terminado" => "respuesta_usuarios#terminado", :as => "terminado"

  resources :usuarios , except: [:destroy] do
    resources :tema_comentarios, only: [:create]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :temas, except: [:destroy] do
    resources :tema_comentarios, only: [:create]
  end
  resources :tema_comentarios, only: [:create]
  resources :grupos, except: [:destroy]  do
    resources :subscripcions, only: [:create]
  end
  resources :subscripcions, only: [:create]
  resources :tareas, except: [:destroy] do
    resources :tarea_comentarios
  end
  resources :tarea_comentarios
  resources :cuestionarios, only: [:create, :edit, :update, :delete]
  resources :eventos
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
 root :to => 'temas#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end
  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable
  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
