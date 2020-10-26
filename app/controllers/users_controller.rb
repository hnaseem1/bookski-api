class UsersController < ApplicationController
    
    def show
        render :json => User.all
    end

    def create
        @user = User.create!(user_params)
        render :json => @user
    end

    private 
    
    def user_params
        # whitelist params
        params.permit(:username)
    end
end
