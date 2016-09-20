class CommentsController < ApplicationController
  helper_method :parent_object
  
  def create
    @comment = parent_object.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.is_author_of?(@comment)
    respond_to do |format|
      format.json { render head :no_content }
    end
  end

  private

  def parent_object
    @obj = request.original_fullpath[/[\w]+/]
    @object ||= @obj.classify.constantize.find(params["#{@obj.singularize}".+('_id').to_sym])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end