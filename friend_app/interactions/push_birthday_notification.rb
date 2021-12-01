class PushBirthdayNotification < FriendAppInteraction
    string: birthday_user_id
    def execute
        ActiveRecord::Base.transaction do
          return execute_transaction_code
        end
    end
    def execute_transaction_code
        mail_id=Following.where(following_id:self.birthday_user_id).pluck(:friend_app_user_id)
        mail_id.each do |ID|
            email_data={}
            email_data[:recipient_email]=FriendaAppUser.find(id:ID).email_id
            email_data[:template] = "birthday_noti"
            
            email_data[:variables] = {
                birthday_name: FriendaAppUser.find(id:birthday_user_id).name.to_s.titleize,
                name: FriendaAppUser.find(id:ID).email_id.to_s.titleize
            }
            SendTransactionalEmail.delay(queue: 'low').run!(email_data)

        end
    end
    

end