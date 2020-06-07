class RoomsController < ApplicationController
before_action :authenticate_user
before_action :check_logout, {only: [:new, :create]}
before_action :check_correct_room, {only: [:destroy]}

    def index
        @rooms = Room.all
    end

    def new
        @room = Room.new
    end

    def create
        @room = Room.new(title: params[:room_title], user_id: @current_user.id)
        if @room.save
            @post = Post.new(content: params[:content], room_id: @room.id, user_id: @current_user.id)
            str = @post.content + @word
            @post.content = str
            if @post.save
                flash[:notice] = "部屋を作りました"
                redirect_to("/rooms/index")
            else
                @error_message = "内容が投稿できませんでした"
                render("rooms/show")
            end
        else
            @error_message = "部屋を作れませんでした"
            render("rooms/new")
        end
    end

    def destroy
        @room = Room.find_by(id: params[:id])
        @room.posts.each do |post|
            post.destroy
        end
        @room.destroy
        flash[:notice] = "部屋を削除しました"
        redirect_to("/rooms/index")
    end

    def show
      @room = Room.find_by(id: params[:id])
    end
end
