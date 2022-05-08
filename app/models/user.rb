class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :follow_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :follows, through: :follow_relationships, source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  scope :filter_by_name, lambda { |text, matcher|
    where('name LIKE ?',
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
