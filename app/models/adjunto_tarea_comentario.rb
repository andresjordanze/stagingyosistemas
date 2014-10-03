class AdjuntoTareaComentario < ActiveRecord::Base
  belongs_to :tarea_comentario
  attr_accessor :archivo
	has_attached_file :archivo,
  					:storage => :dropbox,
  					:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
					:dropbox_options => {:path =>proc { |style| "tarea_comentarios/#{tarea_comentario_id}/#{id}-#{archivo.original_filename}" } , :unique_filename => true}
end
