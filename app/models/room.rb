class Room < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 100}}

    def posts
        return Post.where(room_id: self.id)
    end

    def user
        return User.find_by(id: self.user_id)
    end

end