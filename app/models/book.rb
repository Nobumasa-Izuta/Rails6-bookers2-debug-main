class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :filter_by_title, lambda { |text, matcher|
    where('title LIKE ?',
          case matcher
          when '完全一致'
            text
          when '前方一致'
            "#{text}%"
          when '後方一致'
            "%#{text}"
          when '部分一致'
            "%#{text}%"
          end)
  }
end
