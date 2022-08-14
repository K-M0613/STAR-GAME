class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :comments, dependent: :destroy





  has_one_attached :profile_image

  def active_for_authentication?
    super && (is_delete == false)
  end

  def self.guest
    find_or_create_by!(nickname: 'guestuser' ,email: 'guest@example.com',gender: 0,birth_day: 'none',profile_image_url: 'images/no_image.jpg') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  enum gender: { '男': 0, '女': 1 }
end
