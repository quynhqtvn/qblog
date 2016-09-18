class EntriesController < ApplicationController
	before_action :find_entry, only: [:show, :edit, :update, :destroy]
	def index
	end

	def new
		@entry = Entry.new
	end

	def create
		@entry = Entry.new entry_params

		if @entry.save
			redirect_to @entry, notice: "Entry created succesfully!"
		else
			redirect_to entries_path
		end
	end

	def show
	end

	def edit 
	end

	def update 
		if @entry.update entry_params
			redirect_to @entry, notice: "Your article was succesfully saved!"
		else
			render 'edit'
		end
	end

	def destroy
		@entry.destroy
		redirect_to entries_path
	end


	private

		def entry_params
			params.require(:entry).permit(:title, :content)
		end

		def find_entry
			@entry = Entry.find(params[:id])
		end
end
