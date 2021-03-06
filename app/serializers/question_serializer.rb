class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :short_title, :class_name

  has_many :answers
  has_many :comments
  has_many :attachments

  def short_title
    object.title.truncate(10) if object.persisted?
  end

  def class_name
    object.class.to_s
  end

end