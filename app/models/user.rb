class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :entries
    has_many :comments
	has_many :active_relationships, class_name:  "Relationship",
	                              foreign_key: "follower_id",
	                              dependent:   :destroy
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower


	def feed
		following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    	Entry.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
	end

	def follow(other_user)
		active_relationships.create(followed_id: other_user.id)
	end

	#unfollow a user
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end
	
	def following?(other_user)
		following.include?(other_user)
	end





end
