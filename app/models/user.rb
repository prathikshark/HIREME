class User < ApplicationRecord
  after_initialize :set_default_role, :if => :new_record?

  validates :name, presence: true
  validates :address, presence: true, unless: -> { admin? }
  validates :phone, presence: true, uniqueness: true, numericality: { only_integer: true }, format: { with: /\A\d{10}\z/, message: "Phone number must be a 10-digit number" }, unless: -> { admin? }

  has_one :worker, dependent: :destroy
  has_one :customer, dependent: :destroy
  accepts_nested_attributes_for :worker
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end
  
  enum role: [:customer, :worker, :admin]

  def set_default_role
    self.role ||= :customer if new_record?
  end

end
