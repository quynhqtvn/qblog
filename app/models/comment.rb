class Comment < ActiveRecord::Base
	attr_accessible :content, :email, :entry, :user
  belongs_to :entry
  belongs_to :user
end
