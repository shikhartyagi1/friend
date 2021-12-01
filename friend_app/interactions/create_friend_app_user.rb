class CreateFriendAppUser < FriendAppInteraction
    string :name
    string :user_id 
    string :email_id
    string :birthday 
    validates :name, presence: true
    validates :user_id, presence: true
    validates :email_id, presence: true
    validates :birthday, presence: true

    def execute
        ActiveRecord::Base.transaction do 
            return execute_transaction_code
        end
    end

    def execute_transaction_code
        obj=FriendAppUser.new(name:self.name.upcase,user_id:self.user_id.downcase,email_id:self.email_id.downcase,birthday:self.birthday.to_datetime)
        unless obj.save
            return obj.error
        end
        
    end

    

end