class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :update, :destroy]

  # GET /channels
  def index
    @channels = Channel.all
    json_response(@channels)
  end

  # POST /channels
  def create
    @channel = Channel.create!(channel_params)
    json_response(@channel, :created)
  end

  # GET /channels/:id
  def show
    json_response(@channel)
  end

  # PUT /channels/:id
  def update
    @channel.update(channel_params)
    head :no_content
  end

  # DELETE /channels/:id
  def destroy
    @channel.destroy
    head :no_content
  end

  private

  def channel_params
    # whitelist params
    params.permit(:name)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
