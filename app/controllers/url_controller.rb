class UrlController < ApplicationController
	def create
		@url = Url.new(url_params)
  		@url.save
  		redirect_to :back
	end

	def agregar_url
		@urls = Url.order("created_at DESC")
	end

	private
	def url_params
      params.require(:url).permit(:direccion)
    end
end
