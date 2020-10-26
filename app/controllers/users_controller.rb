class UsersController < ApplicationController
    before_action :set_user, only: [:show]
    
    def show
        json_response(@user)
    end

    def index
        json_response(User.all)
    end

    def create
        @user = User.create!(user_params)
        json_response(@user, :created)
    end

    # a route to login as a user using username
    # a route to send a message to a another user
    # a route to send a message on a channel

    private 
    
    def user_params
        # whitelist params
        params.permit(:username)
    end

    def set_user
        # whitelist params
        @user = User.where(username: params[:id])
        if @user.empty? 
            raise ActiveRecord::RecordNotFound.new "Couldn't find User"
        end
    end
end
