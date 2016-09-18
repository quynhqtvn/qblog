class WelcomeController < ApplicationController
	def index
		@entries = Entry.all.limit(3).order("created_at desc")
	end
end
