class FriendAppUser < FriendAppDatabaseModel
    has_many :followings
    validates :user_id, uniqueness: { case_sensitive: false }
    validates :email_id, uniqueness: { case_sensitive: false }

end