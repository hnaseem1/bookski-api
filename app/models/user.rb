class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
end
