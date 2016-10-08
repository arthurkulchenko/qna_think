class CommentsController < ApplicationController
  helper_method :parent_question_id, :parent
  before_action :parent, only: [:create]
  before_action :authorship_verification, only: [:destroy]
  authorize_resource
  
  respond_to :js
  
  def create
    respond_with(@comment = parent.comments.create(comment_params.merge(user: current_user)))
  end

  def destroy
    respond_with(@comment.delete)
  end

  private

  def authorship_verification
    @comment = Comment.find(params[:id])
    redirect_to @comment, notice: 'Deny!' unless current_user.is_author_of?(@comment)
  end

  def parent
    @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{request.original_fullpath[/[\w]+/].singularize}".+('_id').to_sym])
  end

  def parent_question_id
    @question_id = parent.try(:question_id) || parent.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end