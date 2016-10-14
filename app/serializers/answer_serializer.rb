class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :updated_at, :comments
  belongs_to :question
  has_many :comments
end
