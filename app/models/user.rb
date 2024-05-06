class User < ApplicationRecord
    after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  enum role: [:customer, :worker, :admin]


  has_one :worker, inverse_of: :user, dependent: :destroy
  has_one :customer, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :worker

  def set_default_role
    self.role||=:customer
  end

end
