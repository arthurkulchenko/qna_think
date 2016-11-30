class SearchingsController < ApplicationController
  skip_authorization_check

  def create
    respond_to do |format|
      format.json { render json: searching_for(params[:query], params[:area]) }
    end
  end

  private

    def searching_for(text, in_area)
      @result = 
                if in_area == "Global"
                  ThinkingSphinx.search prepare(text), classes: [User, Question, Answer, Comment]
                else
                  if ["User", "Question", "Answer", "Comment"].include?(in_area)
                    in_area.classify.safe_constantize.search prepare(text)
                  end
                end
      @result.push content: "Nothing is found" if @result.empty?
    end

    def prepare(text)
      %w(@).each { |s| text.gsub!(s, "\\"+s) if text.include?(s) }
      text
    end

end