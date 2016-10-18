class AttachmentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::UrlHelper
  attributes :id, :attachments_link
  
  def attachments_link
    'http://localhost:3000' + url_for(object.file.url)
  end
end
