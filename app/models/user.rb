class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  [:questions, :answers, :votes, :comments, :attachments].each do |model|
    has_many model, dependent: :destroy
  end

  def is_author_of?(obj)
    obj.user_id == id
  end

end
