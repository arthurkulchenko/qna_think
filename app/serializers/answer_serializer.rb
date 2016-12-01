class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :updated_at, :class_name

  # belongs_to :question
  
  has_many :comments
  has_many :attachments

  def class_name
    object.class.to_s
  end

end
