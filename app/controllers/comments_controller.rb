class CommentsController < ApplicationController
  helper_method :parent
  before_action :parent_question_id, only: [:create]
  
  def create
    @comment = parent.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.is_author_of?(@comment)
    respond_to do |format|
      format.json { render :nothing => true }
    end
  end

  private

  def parent
    @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{@obj.singularize}".+('_id').to_sym])
  end

  def parent_question_id
    @question_id = parent.try(:question_id) || parent.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end