class PushBirthdayMails
    include Sidekiq::Worker
    sidekiq_options queue: 'low', :retry => 0, :backtrace => true
    CRON = '0 0 * * *'
    ARGS = {}
    def perform
        FriendaAppUser.each do |user|
            if(user.pluck(:birthday).strftime("%m/%d")==Time.now.strftime("%m/%d"))
                PushBirthdayNotification(user.id)
            end
        end
        
    end



end