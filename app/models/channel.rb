class Channel < ApplicationRecord
    validates :name, uniqueness: true, presence: true
    has_many :channel_messages, dependent: :destroy, inverse_of: :channel
end
