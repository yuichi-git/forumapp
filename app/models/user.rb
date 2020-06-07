class User < ApplicationRecord
    has_secure_password
    validates :name, {presence: true, uniqueness: true}
    validates :password_digest, {presence: true}

    def posts
        return Post.where(user_id: self.id)
    end

    def rooms
        return Room.where(user_id: self.id)
    end
end
