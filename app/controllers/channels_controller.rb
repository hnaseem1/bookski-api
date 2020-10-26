class ChannelsController < ApplicationController
    def create
        @channel = Channel.create!(channel_params)
        render :json => @channel
    end

    def index 
        render :json => Channel.all
    end

    private

    def channel_params
        params.permit(:name)
    end
end
