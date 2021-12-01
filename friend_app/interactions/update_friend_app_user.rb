class UpdateFriendAppUser < FriendAppInteraction
    string :user_id
    string :birthday
    def execute
        ActiveRecord::Base.transaction do 
            return execute_transaction_code
        end
    end
    def execute_transaction_code
        user=FriendAppUser.find(user_id)
        user.birthday=self.birthday
        unless user.save
            return user.error
        end
    end

end