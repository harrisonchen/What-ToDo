class StaticPagesController < ApplicationController
  	
  	def home
  		store_path root_path
  	end
end
