class CommentsController < ApplicationController
	before_action :find_entry
	before_action :find_comment, only: [:destroy, :edit, :update]
	def create
		@entry = Entry.find(params[:entry_id])
		@comment = @entry.comments.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.save

		redirect_to entry_path(@entry)
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to entry_path(@entry)
		else
			render 'edit'
		end
	end


	def destroy
		@entry = Entry.find(params[:entry_id])
		@comment = @entry.comments.find(params[:id])
		@comment.destroy

		redirect_to entry_path(@entry)
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end
	def find_entry
		@entry = Entry.find(params[:entry_id])
	end

	def find_comment
		@comment = @entry.comments.find(params[:id])
	end

end
