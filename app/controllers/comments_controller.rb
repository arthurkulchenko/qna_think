class CommentsController < ApplicationController
  helper_method :parent_object
  before_action :parent_question_id, only: [:create]
  
  def create
    # parent_object
    @comment = parent_object.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    # respond_to do |format|
      # if @comment.save
        # format.js
        # format.json { render json: @comment }
      # else
        # format.js
        # format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      # end
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.is_author_of?(@comment)
    respond_to do |format|
      format.json
    end
  end

  private

  def parent_object
    @object ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{@obj.singularize}".+('_id').to_sym])
  end

  def parent_question_id
    @question_id = parent_object.try(:question_id) || parent_object.id
                   # if parent_object.class.to_s == "Question" 
                   #   parent_object.id
                   # else
                   #   parent_object.question_id 
                   # end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end