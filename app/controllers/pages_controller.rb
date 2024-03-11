class PagesController < ApplicationController
	# def show
	# 	@page = current_site.pages.find(params[:id])
	# 	render json: @page
	# end
	def index
		render json: current_site.pages
	end
end
