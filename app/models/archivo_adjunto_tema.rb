class ArchivoAdjuntoTema < ActiveRecord::Base
  belongs_to :tema
  attr_accessor :archivo
	has_attached_file :archivo,
  					:storage => :dropbox,
  					:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",
					:dropbox_options => {:path =>proc { |style| "temas/#{tema_id}/#{id}-#{archivo.original_filename}" } , :unique_filename => true}
end
