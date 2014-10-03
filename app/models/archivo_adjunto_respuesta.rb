class ArchivoAdjuntoRespuesta < ActiveRecord::Base
	belongs_to :responder_tarea
	attr_accessor :archivo
	has_attached_file :archivo,
  					:storage => :dropbox,
  					:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
					:dropbox_options => {:path =>proc { |style| "respuesta_tarea/#{responder_tarea_id}/#{id}-#{archivo.original_filename}" } , :unique_filename => true}
end