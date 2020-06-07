class Post < ApplicationRecord
    validates :content, {presence: true}
    validates :room_id, {presence: true}
    validates :user_id, {presence: true}

    def user
        return User.find_by(id: self.user_id)
    end
end