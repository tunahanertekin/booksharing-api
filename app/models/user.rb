class User < ApplicationRecord
    has_many :books, dependent: :destroy
    has_many :swap_requests, dependent: :destroy
    has_many :exchanges, dependent: :destroy
end
