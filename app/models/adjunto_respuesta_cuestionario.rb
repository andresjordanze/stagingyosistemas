class AdjuntoRespuestaCuestionario < ActiveRecord::Base
  belongs_to :respuesta_usuario
  attr_accessor :archivo
	has_attached_file :archivo,
  					:storage => :dropbox,
  					:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
					:dropbox_options => {:path =>proc { |style| "respuesta_cuestionario/#{respuesta_usuario_id}/#{id}-#{archivo.original_filename}" } , :unique_filename => true}
end
