class SearchingsController < ApplicationController
  skip_authorization_check

  def create
    @valid_models = [User, Question, Answer, Comment]
    @string_models = ["User", "Question", "Answer", "Comment"]
    @result = 
              if params[:searching] == "Global"
                ThinkingSphinx.search params[:query], classes: @valid_models
              else
                if @string_models.include?(params[:searching])
                  params[:searching].safe_constantize.search params[:query]
                else
                  flash[:notice] = "Don't mess with me!"
                end
              end
    respond_to do |format|
      format.json { render json: @result }
    end
  end

end