class PostsController < ApplicationController
before_action :check_logout
before_action :check_correct_post, {only: [:destroy]}

    def create
        @post = Post.new(content: params[:content], room_id: params[:room_id], user_id: @current_user.id)
        str = @post.content + @word
        @post.content = str
        if @post.save
            flash[:notice] = "投稿しました"
            redirect_to("/rooms/#{params[:room_id]}")
        else
            @error_message = "内容が投稿できませんでした"
            redirect_to("/rooms/#{params[:room_id]}")
        end
    end

    def destroy
        @post = Post.find_by(id: params[:id])
        @room = Room.find_by(id: @post.room_id)
        @post.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to("/rooms/#{@room.id}")
    end
end