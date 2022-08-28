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
    user = find_or_create_by(nickname: "guestuser",
                              email: "guest@example.com",
                              gender: 0,
                              birth_day: "none")
    user.password = SecureRandom.urlsafe_base64
    user.is_delete = false
    user.save
    user
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    else
      profile_image
    end
  end

  enum gender: { '男': 0, '女': 1 }
end
