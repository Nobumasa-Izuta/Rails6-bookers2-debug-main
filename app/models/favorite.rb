class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, uniqueness: { scope: :user }
end
