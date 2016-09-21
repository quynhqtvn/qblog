class FeedController < ApplicationController
	def index
		if user_signed_in?
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
end
