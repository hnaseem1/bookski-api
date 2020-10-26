class ChannelMessage < ApplicationRecord
  belongs_to :channel, inverse_of: :channel_messages
  belongs_to :user
end
