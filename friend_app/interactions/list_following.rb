lass ListFollower < FriendAppInteraction
    string :user_id
    integer :page_limit, default: 10
    integer :page, default: 1
    boolean :pagination_data_required, default: true

  
    def execute
   
        friend_app_user_id=FriendAppUser.where(user_id:self.user_id.downcase).pluck(:id)
        query = get_query(friend_app_user_id)
        data=get_data(query)
        pagination_data = get_pagination_data(query)
    
        {list: data}.merge!(pagination_data)  
    end
    def get_query(new_id)
        Following.page(self.page).per(self.page_limit).where(following_id:new_id).pluck(:following_id)
    end
    def get_data(query)
        temp=[]
        query.each do |following_id|
            temp << FriendAppUser.where(id:following_id).as_json[0]
        end
        return temp
    end
    
    
    def get_pagination_data(query)
        return {} unless self.pagination_data_required
        {
          page: self.page,
          page_limit: self.page_limit
        }
    end

end