class CommentsController < ApplicationController
  helper_method :parent_question_id, :parent
  before_action :parent, only: [:create]
  
  def create
    @comment = parent.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.is_author_of?(@comment)
  end

  private

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