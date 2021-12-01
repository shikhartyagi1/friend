class FollowFriend < FriendAppInteraction
    string :user_id
    string :friend_user_id
    validates :user_id, presence: true
    validates :friend_user_id, presence: true
    def execute
        ActiveRecord::Base.transaction do 
            return execute_transaction_code
        end
    end

    def execute_transaction_code
        friend_app_user_id=FriendAppUser.find_by(user_id:self.user_id.downcase).id
        following_id=FriendAppUser.find_by(user_id:self.friend_user_id.downcase).id
        obj=Following.new(friend_app_user_id:friend_app_user_id,following_id:following_id)
        unless obj.save
            return obj.error
        end
        obj2=FriendAppUser.find(friend_app_user_id)
        obj2.total_following+=1;
        unless obj2.save
            return obj2.error
        end
        obj3=FriendAppUser.find(following_id)
        obj3.total_follower+=1;
        unless obj3.save
            return obj3.error
        end
        
    end


end