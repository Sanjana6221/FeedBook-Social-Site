class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts,dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  serialize :language

  ALLOWED_LANGUAGES = ["Hindi", "English", "Other"]
  
end



 