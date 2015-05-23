class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable


  validates :first_name,  presence:    true,
                          length:      { in:1..255 }
  validates :last_name,   presence:    true,
                          length:      { in:1..255 }
  validates :username,    presence:    true,
                          uniqueness:  { case_sensitive:  false },
                          length:      { in:2..255 }
  validates :password_confirmation, presence: true,
                                    confirmation: true,
                                    unless: lambda { |user| user.password.blank? }
end
