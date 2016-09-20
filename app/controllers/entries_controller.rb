class EntriesController < ApplicationController
	before_action :find_entry, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :correct_user, only: [:edit, :destroy]
	def index
		@entries = Entry.all.order("created_at desc").paginate(page: params[:page], per_page: 3)
	end

	def new
		@entry = Entry.new
	end

	def create
		@entry = current_user.entries.build(entry_params)

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
		redirect_to entries_path, notice: "Entry deleted!"
	end


	private

		def entry_params
			params.require(:entry).permit(:title, :content)
		end

		def find_entry
			@entry = Entry.find(params[:id])
		end

		def correct_user
			@entry = current_user.entries.find_by(id: params[:id])
			redirect_to root_url if @entry.nil?
		end
end
