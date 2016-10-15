class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :short_title

  has_many :answers
  has_many :comments
  has_many :attachments
  # belongs_to :user

  def short_title
    object.title.truncate(10) if object.persisted?
  end
end
