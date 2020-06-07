class UsersController < ApplicationController
before_action :check_login, {only: [:login_form, :login]}
before_action :check_logout, {only: [:show, :logout, :edit, :update]}
before_action :check_correct_user, {only: [:edit, :update, :destroy]}

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/users/#{@user.id}")
        else
            flash[:notice] = "更新に失敗しました"
            render("users/edit")
        end
    end

    def create
        @user = User.new(name: params[:name], password: params[:password])
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "登録が完了しました"
            redirect_to("/rooms/index")
        else
            @error_message = "空欄があるか、既に存在するユーザー名です"
            render("users/signup")
        end
    end

    def login
        @user = User.find_by(name: params[:name])
        @name = params[:name]
        @password = params[:password]
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "ログインしました"
            redirect_to("/rooms/index")
        else
            @error_message = "ログインに失敗しました"
            render("users/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/")
    end

    def login_form
        @user = User.new
    end

    def signup
        @user = User.new
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.posts.each do |post|
            post.destroy
        end
        @user.rooms.each do |room|
            room.destroy
        end
        @user.destroy
        flash[:notice] = "ユーザーを削除しました"
        redirect_to("/rooms/index")
    end
end