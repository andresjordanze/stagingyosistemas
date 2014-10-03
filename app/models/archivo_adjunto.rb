class ArchivoAdjunto < ActiveRecord::Base
	belongs_to :tarea
	attr_accessor :archivo
	has_attached_file :archivo,
  					:storage => :dropbox,
  					:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
					:dropbox_options => {:path =>proc { |style| "tareas/#{tarea_id}/#{id}-#{archivo.original_filename}" } , :unique_filename => true}
end