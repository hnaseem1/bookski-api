class ChannelMessagesController < ApplicationController
  before_action :set_channel
  before_action :set_channel_message, only: [:show, :update, :destroy]

  # GET /channels/:channel_id/messages
  def index
    json_response(@channel.channel_messages)
  end

  # GET /channels/:channel_id/messages/:id
  def show
    json_response(@message)
  end

  # POST /channels/:channel_id/messages
  def create
    @channel.channel_messages.create!(message_params)
    json_response(@channel, :created)
  end

  # PUT /channels/:channel_id/messages/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /channels/:channel_id/messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.permit(:message, :user_id)
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_channel_message
    @message = @channel.channel_messages.find_by!(id: params[:id]) if @channel
  end    
end
