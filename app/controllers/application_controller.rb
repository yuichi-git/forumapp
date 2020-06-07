class ApplicationController < ActionController::Base
before_action :authenticate_user
before_action :word_select

    def authenticate_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def check_logout
        if @current_user == nil
            flash[:notice] = "ログインしてください"
            redirect_to("/login")
        end
    end

    def check_login
        if @current_user != nil
            flash[:notice] = "ログインしています"
            redirect_to("/rooms/index")
        end
    end

    def check_correct_room
        @room = Room.find_by(id: params[:id])
        if @current_user.id != @room.user_id
            flash[:notice] = "権限がありません"
            redirect_to("/rooms/index")
        end
    end

    def check_correct_user
        if @current_user.id != params[:id].to_i
            flash[:notice] = "権限がありません"
            redirect_to("/")
        end
    end

    def check_correct_post
        @post = Post.find_by(id: params[:id])
        if @current_user.id != @post.user_id
            flash[:notice] = "権限がありません"
            redirect_to("/")
        end
    end

    def word_select
        word_list = ["だワン", "ゲロゲロ", "だミャー", "ブヒブヒ", "だモー", "だぴょん", "だピヨ"]
        @word = word_list[rand(word_list.size)]
    end
end