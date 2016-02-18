class User < ApplicationRecord
  has_many :messages

  validates :name, length: { minimum: 3 }
end
