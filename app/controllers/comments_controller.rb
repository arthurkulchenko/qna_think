class CommentsController < ApplicationController
  include Parent
  helper_method :parent_question_id, :parent, :channel_path
  before_action :parent, only: [:create]
  authorize_resource
  before_action :authorship_verification, only: [:destroy]
  
  respond_to :js, :json
  
  def create
    @comment = parent.comments.create(comment_params.merge(user: current_user))
    ActionCable.server.broadcast channel_path(@comment), @comment
    respond_with @comment
    # respond_with @comment do |format|
    #   format.js { render nothing: true }
    # end
  end

  def destroy
    respond_with @comment.delete do |format|
      format.js { render nothing: true }
    end
  end

  private

  def channel_path(comment)
    @to_question = "/question/#{parent_question_id}" 
    comment.parent_type == "Question" ? @path = @to_question : @path = @to_question + '/answers'
    @path += "/comments"
  end

  def authorship_verification
    @comment = Comment.find(params[:id])
    redirect_to @comment, notice: 'Deny!' unless current_user.is_author_of?(@comment)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end